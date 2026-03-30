extends Node2D
class_name VigilSpanSlice

enum SliceObjective {
	REACH_HOLD,
	CHOOSE_ROUTE,
	RETURN_TO_SPAN,
	RESOLVE_RETURNING,
	CHANGED_REVISIT,
	COMPLETE,
}

@onready var player: PlayerLune = $PlayerLune
@onready var relay_lantern: RelayLantern = $RelayLantern
@onready var lawful_source: WitnessSource = $WitnessSources/LawfulBellEye
@onready var false_source: WitnessSource = $WitnessSources/FalseCallSource
@onready var main_bridge: WitnessRouteSegment = $RouteSegments/MainBridge
@onready var side_bridge: WitnessRouteSegment = $RouteSegments/SideBridge
@onready var hold_point: HoldPoint = $HoldPoints/MainHold
@onready var slice_state: SliceState = $SliceState
@onready var setpiece_director: ReturnConflictDirector = $SetpieceDirector
@onready var audio_director: MusicDirector = $AudioDirector
@onready var status_label: Label = $UI/HUD/StatusLabel
@onready var objective_label: Label = $UI/HUD/ObjectiveLabel
@onready var hint_label: Label = $UI/HUD/HintLabel
@onready var route_label: Label = $UI/HUD/RouteLabel
@onready var route_glow: Line2D = $LandingGeometry/RouteGlow
@onready var iri_marker: Label = $LandingGeometry/IriMarker
@onready var nao_marker: Label = $LandingGeometry/NaoMarker
@onready var start_marker: Label = $LandingGeometry/StartMarker
@onready var hold_marker: Label = $LandingGeometry/HoldMarker
@onready var iri_visual: Polygon2D = $Characters/Iri/Visual
@onready var nao_visual: Polygon2D = $Characters/Nao/Visual
@onready var yun_visual: Polygon2D = $Characters/Yun/Visual
@onready var sera_visual: Polygon2D = $Characters/Sera/Visual
@onready var blind_ward_visual: Polygon2D = $Zones/BlindWard/Visual
@onready var false_field_visual: Polygon2D = $Zones/FalseField/Visual
@onready var return_goal_visual: Polygon2D = $Zones/ReturnGoal/Visual

var in_blind_ward: bool = false
var in_false_field: bool = false
var setpiece_started: bool = false
var revisit_state_active: bool = false
var answer_boost_time: float = 0.0
var knot_anchor_time: float = 0.0
var transient_hint_text: String = ""
var transient_hint_time: float = 0.0
var route_lost_time: float = 0.0
var current_objective: int = SliceObjective.REACH_HOLD
var checkpoint_position: Vector2
var wrong_route_committed: bool = false
var revisit_outcome: StringName = &""
var revisit_wrong_light_time: float = 0.0
var guide_pulse_time: float = 0.0

var _lane_start_main := Rect2(-560.0, 72.0, 880.0, 96.0)
var _lane_iri := Rect2(-266.0, -20.0, 196.0, 110.0)
var _lane_nao := Rect2(180.0, -82.0, 262.0, 120.0)
var _lane_sera := Rect2(262.0, 86.0, 204.0, 72.0)


func _ready() -> void:
	relay_lantern.attach_to_carrier(player)
	relay_lantern.set_source(lawful_source)
	player.set_carrying(true)
	checkpoint_position = player.global_position

	$Zones/BlindWard.body_entered.connect(_on_blind_ward_entered)
	$Zones/BlindWard.body_exited.connect(_on_blind_ward_exited)
	$Zones/FalseField.body_entered.connect(_on_false_field_entered)
	$Zones/FalseField.body_exited.connect(_on_false_field_exited)
	$Zones/MisarrivalPocket.body_entered.connect(_on_misarrival_pocket_entered)
	$Zones/SetpieceTrigger.body_entered.connect(_on_setpiece_trigger_entered)
	$Zones/ReturnGoal.body_entered.connect(_on_return_goal_entered)

	hold_point.hold_reached.connect(_on_hold_reached)
	player.answer_used.connect(_on_player_answer_used)
	player.knot_used.connect(_on_player_knot_used)
	player.cut_used.connect(_on_player_cut_used)
	setpiece_director.phase_changed.connect(_on_phase_changed)
	setpiece_director.resolution_changed.connect(_on_resolution_changed)
	_set_transient_hint("Start with WASD. Hold RMB to read route truth. Stay on the blue span first.", 3.0)
	_update_ui()


func _process(delta: float) -> void:
	answer_boost_time = max(0.0, answer_boost_time - delta)
	knot_anchor_time = max(0.0, knot_anchor_time - delta)
	transient_hint_time = max(0.0, transient_hint_time - delta)
	revisit_wrong_light_time = max(0.0, revisit_wrong_light_time - delta)
	guide_pulse_time += delta

	var false_field_source := _get_false_field_source()
	var blind_ward_active := _is_blind_ward_active()
	relay_lantern.update_tether(delta, blind_ward_active, false_field_source)
	main_bridge.apply_tether_state(relay_lantern.current_state)
	side_bridge.apply_tether_state(RelayLantern.TetherState.HELD_WRONG if in_false_field else relay_lantern.current_state)
	_apply_changed_revisit_feedback()
	if knot_anchor_time > 0.0:
		main_bridge.set_state(WitnessRouteSegment.RouteState.HELD_TRUE)
	_constrain_player_to_lane()
	_update_changed_revisit()
	_update_route_failure(delta)
	_update_audio_state()
	_update_world_guidance()
	_update_ui()


func _update_audio_state() -> void:
	if setpiece_director.current_phase == ReturnConflictDirector.Phase.HOLD_THE_MIDDLE or setpiece_director.current_phase == ReturnConflictDirector.Phase.SPATIAL_CHOICE:
		audio_director.set_layer(MusicDirector.LayerState.CONFLICT)
		return

	match relay_lantern.current_state:
		RelayLantern.TetherState.CLEAN:
			audio_director.set_layer(MusicDirector.LayerState.LAWFUL)
		RelayLantern.TetherState.THINNING:
			audio_director.set_layer(MusicDirector.LayerState.THINNING)
		RelayLantern.TetherState.HELD_WRONG:
			audio_director.set_layer(MusicDirector.LayerState.HELD_WRONG)
		RelayLantern.TetherState.LOST:
			audio_director.set_layer(MusicDirector.LayerState.LOST)


func _update_ui() -> void:
	status_label.text = "Music: %s\nSuspicion: %d\nArrival: %s\nSetpiece: %s" % [
		audio_director.get_layer_name(),
		slice_state.suspicion_level,
		slice_state.get_arrival_state_name(),
		setpiece_director.get_phase_name(),
	]
	objective_label.text = "Objective: %s" % _get_objective_text()
	route_label.text = "Lantern: %s | Main: %s%s" % [relay_lantern.get_state_name(), main_bridge.get_state_name(), _get_route_suffix()]
	if transient_hint_time > 0.0:
		hint_label.text = transient_hint_text
	elif slice_state.has_frayed_bell_thread:
		hint_label.text = "Frayed Bell Thread secured. Wrong routes buy time, but not trust."
	elif revisit_state_active:
		hint_label.text = _get_revisit_hint()
	else:
		hint_label.text = "Carry the relay. Focus through blind wards. Let the wrong light tempt you."


func _update_world_guidance() -> void:
	var pulse := 0.82 + 0.18 * sin(guide_pulse_time * 3.8)
	_reset_world_guidance()

	match current_objective:
		SliceObjective.REACH_HOLD:
			hold_marker.text = "Main Hold"
			_set_route_glow_world_points([Vector2(-420, 120), hold_point.global_position])
			_highlight_marker(hold_marker, null, Color(0.95, 0.82, 0.48), pulse)
		SliceObjective.CHOOSE_ROUTE:
			nao_marker.text = "Wrong Light"
			hold_marker.text = "Main Hold"
			_set_route_glow_world_points([hold_point.global_position, Vector2(122, 120), false_source.global_position])
			_highlight_marker(nao_marker, nao_visual, Color(0.95, 0.62, 0.88), pulse)
			_highlight_marker(hold_marker, null, Color(0.95, 0.82, 0.48), 1.04)
		SliceObjective.RETURN_TO_SPAN:
			if slice_state.has_frayed_bell_thread:
				hold_marker.text = "Return To Span"
				_set_route_glow_world_points([Vector2(372, -38), Vector2(160, 120), Vector2(105, 118)])
				_highlight_marker(hold_marker, null, Color(0.95, 0.82, 0.48), pulse)
			else:
				nao_marker.text = "Claim Thread"
				_set_route_glow_world_points([false_source.global_position, Vector2(372, -38)])
				_highlight_marker(nao_marker, nao_visual, Color(0.95, 0.62, 0.88), pulse)
		SliceObjective.RESOLVE_RETURNING:
			iri_marker.text = "Iri"
			nao_marker.text = "Nao"
			hold_marker.text = "Keep Middle"
			_set_route_glow_world_points([Vector2(-170, 20), Vector2(88, 46), Vector2(260, -50)])
			_highlight_marker(iri_marker, iri_visual, Color(0.76, 0.90, 1.0), pulse)
			_highlight_marker(nao_marker, nao_visual, Color(0.95, 0.62, 0.88), pulse)
			_highlight_marker(hold_marker, yun_visual, Color(0.95, 0.82, 0.48), pulse)
		SliceObjective.CHANGED_REVISIT:
			_update_revisit_guidance(pulse)
		SliceObjective.COMPLETE:
			start_marker.text = "Home Bell"
			_set_route_glow_world_points([Vector2(-420, 120), Vector2(-420, 120)])
			_highlight_marker(start_marker, null, Color(0.78, 0.94, 1.0), pulse)


func _update_revisit_guidance(pulse: float) -> void:
	match revisit_outcome:
		&"lawful_return":
			start_marker.text = "Home Bell"
			_set_route_glow_world_points([checkpoint_position, Vector2(-420, 120)])
			_highlight_marker(start_marker, null, Color(0.78, 0.94, 1.0), pulse)
		&"wrong_home":
			if revisit_wrong_light_time > 0.0:
				start_marker.text = "Home Bell"
				nao_marker.text = "Wrong Echo"
				_set_route_glow_world_points([false_source.global_position, checkpoint_position, Vector2(-420, 120)])
				_highlight_marker(start_marker, null, Color(0.78, 0.94, 1.0), pulse)
				_highlight_marker(nao_marker, nao_visual, Color(0.95, 0.62, 0.88), 1.02)
			else:
				nao_marker.text = "Wrong Echo"
				_set_route_glow_world_points([checkpoint_position, false_source.global_position])
				_highlight_marker(nao_marker, nao_visual, Color(0.95, 0.62, 0.88), pulse)
		&"broken_middle":
			if knot_anchor_time > 0.0:
				start_marker.text = "Home Bell"
				hold_marker.text = "Stitched"
				_set_route_glow_world_points([hold_point.global_position, Vector2(-420, 120)])
				_highlight_marker(start_marker, null, Color(0.78, 0.94, 1.0), pulse)
				_highlight_marker(hold_marker, null, Color(0.88, 0.80, 1.0), 1.02)
			else:
				hold_marker.text = "Fracture"
				_set_route_glow_world_points([checkpoint_position, hold_point.global_position])
				_highlight_marker(hold_marker, null, Color(0.88, 0.80, 1.0), pulse)
		_:
			start_marker.text = "Home Bell"
			_set_route_glow_world_points([checkpoint_position, Vector2(-420, 120)])
			_highlight_marker(start_marker, null, Color(0.78, 0.94, 1.0), pulse)


func _reset_world_guidance() -> void:
	start_marker.text = "Start"
	hold_marker.text = "Main Hold"
	iri_marker.text = "Iri Platform"
	nao_marker.text = "Wrong Light"

	start_marker.modulate = Color(0.78, 0.83, 0.92, 0.70)
	hold_marker.modulate = Color(0.78, 0.83, 0.92, 0.70)
	iri_marker.modulate = Color(0.78, 0.83, 0.92, 0.70)
	nao_marker.modulate = Color(0.78, 0.83, 0.92, 0.70)

	start_marker.scale = Vector2.ONE
	hold_marker.scale = Vector2.ONE
	iri_marker.scale = Vector2.ONE
	nao_marker.scale = Vector2.ONE

	iri_visual.modulate = Color(1, 1, 1, 1)
	nao_visual.modulate = Color(1, 1, 1, 1)
	yun_visual.modulate = Color(1, 1, 1, 1)
	sera_visual.modulate = Color(1, 1, 1, 0.78)
	return_goal_visual.modulate = Color(1, 1, 1, 1)

	iri_visual.scale = Vector2.ONE
	nao_visual.scale = Vector2.ONE
	yun_visual.scale = Vector2.ONE
	sera_visual.scale = Vector2.ONE


func _highlight_marker(marker: Label, visual: CanvasItem, accent: Color, pulse: float) -> void:
	marker.modulate = accent
	marker.scale = Vector2.ONE * pulse
	if visual != null:
		visual.modulate = accent.lerp(Color(1, 1, 1, 1), 0.16)
		visual.scale = Vector2.ONE * pulse


func _set_route_glow_world_points(world_points: Array[Vector2]) -> void:
	var local_points := PackedVector2Array()
	for point in world_points:
		local_points.append(route_glow.to_local(point))
	route_glow.points = local_points
	route_glow.width = 16.0 + (sin(guide_pulse_time * 3.8) * 1.4)


func _get_false_field_source() -> WitnessSource:
	if in_false_field and answer_boost_time <= 0.0:
		return false_source
	return null


func _is_blind_ward_active() -> bool:
	if not in_blind_ward:
		return false

	if current_objective == SliceObjective.CHANGED_REVISIT:
		match revisit_outcome:
			&"lawful_return":
				return false
			&"wrong_home":
				return revisit_wrong_light_time <= 0.0
			&"broken_middle":
				return knot_anchor_time <= 0.0

	return knot_anchor_time <= 0.0 and answer_boost_time <= 0.0


func _apply_changed_revisit_feedback() -> void:
	if current_objective != SliceObjective.CHANGED_REVISIT:
		return

	match revisit_outcome:
		&"lawful_return":
			main_bridge.set_state(WitnessRouteSegment.RouteState.HELD_TRUE)
		&"wrong_home":
			if revisit_wrong_light_time > 0.0:
				main_bridge.set_state(WitnessRouteSegment.RouteState.HELD_WRONG)
			elif in_blind_ward:
				main_bridge.set_state(WitnessRouteSegment.RouteState.THINNING)
		&"broken_middle":
			if in_blind_ward and knot_anchor_time <= 0.0:
				main_bridge.set_state(WitnessRouteSegment.RouteState.LOST)


func _update_changed_revisit() -> void:
	if current_objective != SliceObjective.CHANGED_REVISIT:
		return

	match revisit_outcome:
		&"wrong_home":
			if in_blind_ward and revisit_wrong_light_time <= 0.0:
				relay_lantern.force_lost()
		&"broken_middle":
			if in_blind_ward and knot_anchor_time <= 0.0:
				relay_lantern.force_lost()


func _get_route_suffix() -> String:
	if current_objective != SliceObjective.CHANGED_REVISIT:
		return ""

	match revisit_outcome:
		&"wrong_home":
			return " | Echo %.1fs" % revisit_wrong_light_time
		&"broken_middle":
			return " | Stitch %.1fs" % knot_anchor_time
		_:
			return ""


func _get_revisit_hint() -> String:
	match revisit_outcome:
		&"lawful_return":
			return "The public span is holding. Bring the bell home before the district changes its mind."
		&"wrong_home":
			if revisit_wrong_light_time > 0.0:
				return "Wrong echo borrowed. Cut left through the cold ward before it fades."
			return "Public space rejects this return. Brush the Wrong Light again, then cross fast."
		&"broken_middle":
			if knot_anchor_time > 0.0:
				return "The middle is stitched for a breath. Move now."
			return "The center tears on contact. Step in and Knot it before you cross."
		_:
			return "Revisit active. The district remembers what you chose."


func _on_blind_ward_entered(body: Node) -> void:
	if body == player:
		in_blind_ward = true
		if current_objective == SliceObjective.CHANGED_REVISIT:
			match revisit_outcome:
				&"wrong_home":
					if revisit_wrong_light_time <= 0.0:
						_set_transient_hint("The ward goes cold on you. Touch Wrong Light before crossing.", 1.8)
				&"broken_middle":
					if knot_anchor_time <= 0.0:
						_set_transient_hint("This middle will not hold twice for free. Knot it inside the ward.", 1.8)


func _on_blind_ward_exited(body: Node) -> void:
	if body == player:
		in_blind_ward = false


func _on_false_field_entered(body: Node) -> void:
	if body == player:
		in_false_field = true
		if current_objective == SliceObjective.CHANGED_REVISIT and revisit_outcome == &"wrong_home":
			revisit_wrong_light_time = 1.85
			_set_transient_hint("Wrong echo taken. Cross the ward before it burns out.", 1.8)


func _on_false_field_exited(body: Node) -> void:
	if body == player:
		in_false_field = false


func _on_misarrival_pocket_entered(body: Node) -> void:
	if body != player or slice_state.has_frayed_bell_thread:
		return
	if relay_lantern.current_state != RelayLantern.TetherState.HELD_WRONG:
		_set_transient_hint("This ledge will not hold until you let the route resolve wrong.")
		return
	slice_state.grant_frayed_bell_thread()
	slice_state.add_suspicion(1)
	slice_state.set_arrival_state(SliceState.ArrivalState.WRONG_ROUTE)
	wrong_route_committed = true
	current_objective = SliceObjective.RETURN_TO_SPAN
	_set_transient_hint("Frayed Bell Thread gained. Public trust thins.", 2.4)


func _on_setpiece_trigger_entered(body: Node) -> void:
	if body != player or setpiece_started:
		return
	if current_objective == SliceObjective.REACH_HOLD:
		_set_transient_hint("You are skipping the job. Stabilize the Main Hold first.", 1.8)
		return
	if current_objective == SliceObjective.CHOOSE_ROUTE and wrong_route_committed:
		current_objective = SliceObjective.RETURN_TO_SPAN
	setpiece_started = true
	current_objective = SliceObjective.RESOLVE_RETURNING
	if slice_state.arrival_state == SliceState.ArrivalState.UNKNOWN:
		slice_state.set_arrival_state(SliceState.ArrivalState.LAWFUL)
	setpiece_director.start_sequence(slice_state.arrival_state == SliceState.ArrivalState.WRONG_ROUTE)


func _on_hold_reached(body: Node) -> void:
	if body != player:
		return
	if current_objective == SliceObjective.REACH_HOLD:
		current_objective = SliceObjective.CHOOSE_ROUTE
		checkpoint_position = hold_point.global_position + Vector2(-48, 0)
	_set_transient_hint("Hold point regained. Split can be corrected here.", 1.8)
	relay_lantern.set_source(lawful_source)


func _on_player_answer_used(_role_name: StringName) -> void:
	if _is_player_near(lawful_source.global_position, 260.0):
		answer_boost_time = 1.0
		relay_lantern.set_source(lawful_source)
		_set_transient_hint("Lune answers under sanctioned witness. The lawful bell steadies.", 1.6)
		return
	if _is_player_near(false_source.global_position, 200.0):
		_set_transient_hint("The wrong call hears you first. Answering here deepens its pull.", 1.8)
		return
	_set_transient_hint("No route is close enough to answer cleanly.", 1.2)


func _on_player_knot_used() -> void:
	if _is_player_near(hold_point.global_position, 140.0) or in_blind_ward or player.split_recovery_time > 0.0:
		knot_anchor_time = 1.3 if current_objective == SliceObjective.CHANGED_REVISIT and revisit_outcome == &"broken_middle" else 1.0
		player.end_split_recovery()
		relay_lantern.set_source(lawful_source)
		if current_objective == SliceObjective.CHANGED_REVISIT and revisit_outcome == &"broken_middle":
			_set_transient_hint("The split middle takes the knot. Move before it tears again.", 1.8)
			return
		_set_transient_hint("Lune knots the route. The span holds for one more breath.", 1.8)
		return
	_set_transient_hint("Nothing here is loose enough to knot yet.", 1.2)


func _on_player_cut_used() -> void:
	if current_objective == SliceObjective.CHANGED_REVISIT and revisit_outcome == &"wrong_home" and in_false_field:
		revisit_wrong_light_time = 2.15
		relay_lantern.set_state(RelayLantern.TetherState.HELD_WRONG)
		_set_transient_hint("You deepen the wrong echo. Bring it home before the ward strips it away.", 1.8)
		return
	if in_false_field:
		relay_lantern.set_source(false_source)
		relay_lantern.set_state(RelayLantern.TetherState.HELD_WRONG)
		wrong_route_committed = true
		slice_state.set_arrival_state(SliceState.ArrivalState.WRONG_ROUTE)
		current_objective = SliceObjective.RETURN_TO_SPAN
		_set_transient_hint("You cut away from law and bind to the wrong light. Follow it to the ledge.", 2.0)
		return
	if setpiece_director.current_phase == ReturnConflictDirector.Phase.SPATIAL_CHOICE:
		player.enter_split_recovery(1.3)
		_set_transient_hint("You cut the strongest claim and try to hold the middle.", 1.6)
		return
	_set_transient_hint("There is nothing dangerous enough to cut here yet.", 1.2)


func _on_phase_changed(_new_phase: int) -> void:
	match setpiece_director.current_phase:
		ReturnConflictDirector.Phase.DOUBLE_CALL_READ:
			_set_transient_hint("Two homes are speaking. Focus and choose what kind of truth you can survive.", 2.4)
		ReturnConflictDirector.Phase.HOLD_THE_MIDDLE:
			_set_transient_hint("Keep the bridge alive. Lune is the only thing stopping the split from breaking open.", 2.4)
		ReturnConflictDirector.Phase.SPATIAL_CHOICE:
			_set_transient_hint("Move left for Iri, right for Nao, or hold center. Press Space to Call.", 3.2)


func _on_resolution_changed(outcome: StringName) -> void:
	revisit_state_active = true
	revisit_outcome = outcome
	revisit_wrong_light_time = 0.0
	current_objective = SliceObjective.CHANGED_REVISIT
	wrong_route_committed = false
	match outcome:
		&"lawful_return":
			checkpoint_position = Vector2(56, 120)
			lawful_source.source_strength = 1.1
			false_source.source_strength = 0.8
			main_bridge.modulate = Color(0.90, 0.98, 1.0)
			route_glow.default_color = Color(0.60, 0.82, 1.0, 0.34)
			blind_ward_visual.color = Color(0.52, 0.60, 0.74, 0.04)
			false_field_visual.color = Color(0.92, 0.55, 0.84, 0.05)
			return_goal_visual.color = Color(0.78, 0.94, 1.0, 0.12)
			_hint_resolution("Lawful return held. The route is cleaner, but the wound is not.")
		&"wrong_home":
			checkpoint_position = Vector2(96, 120)
			lawful_source.source_strength = 0.85
			false_source.source_strength = 1.25
			main_bridge.modulate = Color(1.0, 0.86, 0.96)
			route_glow.default_color = Color(0.94, 0.62, 0.86, 0.34)
			blind_ward_visual.color = Color(0.52, 0.60, 0.74, 0.14)
			false_field_visual.color = Color(0.95, 0.60, 0.88, 0.18)
			return_goal_visual.color = Color(0.90, 0.86, 1.0, 0.10)
			_hint_resolution("Wrong home won. Private routes deepen. Public space turns colder.")
		&"broken_middle":
			checkpoint_position = Vector2(74, 120)
			lawful_source.source_strength = 0.95
			false_source.source_strength = 1.05
			main_bridge.modulate = Color(0.88, 0.80, 1.0)
			route_glow.default_color = Color(0.82, 0.72, 1.0, 0.34)
			blind_ward_visual.color = Color(0.62, 0.54, 0.90, 0.18)
			false_field_visual.color = Color(0.92, 0.55, 0.84, 0.08)
			return_goal_visual.color = Color(0.78, 0.90, 1.0, 0.10)
			_hint_resolution("No clean home held. The district will remember this fracture.")
	player.global_position = checkpoint_position
	player.velocity = Vector2.ZERO
	relay_lantern.set_source(lawful_source)
	relay_lantern.set_state(RelayLantern.TetherState.CLEAN)


func _hint_resolution(text: String) -> void:
	_set_transient_hint(text, 3.0)


func _on_return_goal_entered(body: Node) -> void:
	if body != player or current_objective != SliceObjective.CHANGED_REVISIT:
		return
	current_objective = SliceObjective.COMPLETE
	player.set_carrying(false)
	_set_transient_hint("Slice complete. You delivered the witness, chose a truth, and brought the wound home.", 4.0)


func _update_route_failure(delta: float) -> void:
	if current_objective == SliceObjective.COMPLETE:
		return
	if relay_lantern.current_state == RelayLantern.TetherState.LOST:
		route_lost_time += delta
		if route_lost_time >= _get_route_loss_grace():
			_fail_to_checkpoint(_get_failure_text())
	else:
		route_lost_time = 0.0


func _get_route_loss_grace() -> float:
	if current_objective != SliceObjective.CHANGED_REVISIT:
		return 0.55

	match revisit_outcome:
		&"lawful_return":
			return 0.68
		&"wrong_home":
			return 0.82
		&"broken_middle":
			return 0.78
		_:
			return 0.60


func _get_failure_text() -> String:
	if current_objective != SliceObjective.CHANGED_REVISIT:
		return "The route forgot you. Lune is thrown back to the last hold."

	match revisit_outcome:
		&"lawful_return":
			return "The public route slips loose. Lune is thrown back before the bell can settle."
		&"wrong_home":
			return "The borrowed echo burns out. Lune is thrown back before the cold ward closes."
		&"broken_middle":
			return "The middle tears again. Lune is thrown back to the last safe span."
		_:
			return "The route forgot you. Lune is thrown back to the last hold."


func _fail_to_checkpoint(reason: String) -> void:
	route_lost_time = 0.0
	slice_state.add_suspicion(1)
	player.global_position = checkpoint_position
	player.velocity = Vector2.ZERO
	player.enter_split_recovery(1.0)
	relay_lantern.set_source(lawful_source)
	relay_lantern.set_state(RelayLantern.TetherState.CLEAN)
	wrong_route_committed = false if current_objective == SliceObjective.CHOOSE_ROUTE else wrong_route_committed
	_set_transient_hint(reason, 2.0)


func _get_objective_text() -> String:
	match current_objective:
		SliceObjective.REACH_HOLD:
			return "Reach Main Hold. Through the ward, use Q or E before the route goes Lost."
		SliceObjective.CHOOSE_ROUTE:
			return "Choose: stay clean to the right, or press F in Wrong Light."
		SliceObjective.RETURN_TO_SPAN:
			return "Take the wrong ledge, claim the thread, then return to the span."
		SliceObjective.RESOLVE_RETURNING:
			return "Hold center, then Space: left Iri, right Nao, center fracture."
		SliceObjective.CHANGED_REVISIT:
			match revisit_outcome:
				&"lawful_return":
					return "Lawful revisit: carry the witness back to Start."
				&"wrong_home":
					return "Wrong revisit: touch Wrong Light, then cut home before Echo fades."
				&"broken_middle":
					return "Broken revisit: Knot the center ward, then carry the bell home."
				_:
					return "Changed revisit: bring the witness back to Start."
		SliceObjective.COMPLETE:
			return "Complete"
		_:
			return "Unknown"


func _constrain_player_to_lane() -> void:
	var allowed_lanes := _get_allowed_lanes()
	if allowed_lanes.is_empty():
		return

	var position := player.global_position
	for lane: Rect2 in allowed_lanes:
		if lane.has_point(position):
			return

	var best_point := position
	var best_distance := INF
	for lane: Rect2 in allowed_lanes:
		var candidate := Vector2(
			clampf(position.x, lane.position.x, lane.position.x + lane.size.x),
			clampf(position.y, lane.position.y, lane.position.y + lane.size.y)
		)
		var distance := position.distance_squared_to(candidate)
		if distance < best_distance:
			best_distance = distance
			best_point = candidate

	player.global_position = best_point


func _get_allowed_lanes() -> Array[Rect2]:
	match current_objective:
		SliceObjective.REACH_HOLD:
			return [_lane_start_main]
		SliceObjective.CHOOSE_ROUTE:
			return [_lane_start_main, _lane_nao]
		SliceObjective.RETURN_TO_SPAN:
			return [_lane_start_main, _lane_nao]
		SliceObjective.RESOLVE_RETURNING:
			return [_lane_start_main, _lane_iri, _lane_nao, _lane_sera]
		SliceObjective.CHANGED_REVISIT:
			match revisit_outcome:
				&"lawful_return":
					return [_lane_start_main, _lane_iri]
				&"wrong_home":
					return [_lane_start_main, _lane_nao]
				&"broken_middle":
					return [_lane_start_main]
				_:
					return [_lane_start_main, _lane_iri]
		SliceObjective.COMPLETE:
			return [_lane_start_main]
		_:
			return [_lane_start_main]


func _is_player_near(point: Vector2, radius: float) -> bool:
	return player.global_position.distance_to(point) <= radius


func _set_transient_hint(text: String, duration: float = 1.6) -> void:
	transient_hint_text = text
	transient_hint_time = duration