extends Node
class_name ReturnConflictDirector

enum Phase {
	IDLE,
	LOADED_APPROACH,
	DOUBLE_CALL_READ,
	HOLD_THE_MIDDLE,
	SPATIAL_CHOICE,
	RESOLVED,
}

signal phase_changed(new_phase: int)
signal resolution_changed(outcome: StringName)

@export var player_path: NodePath
@export var slice_state_path: NodePath
@export var audio_director_path: NodePath
@export var lawful_threshold_x: float = -60.0
@export var wrong_threshold_x: float = 60.0

var current_phase: int = Phase.IDLE
var entry_mode_wrong: bool = false

var _phase_elapsed: float = 0.0
var _phase_durations := {
	Phase.LOADED_APPROACH: 22.0,
	Phase.DOUBLE_CALL_READ: 24.0,
	Phase.HOLD_THE_MIDDLE: 34.0,
	Phase.SPATIAL_CHOICE: 14.0,
}

@onready var player: PlayerLune = get_node_or_null(player_path)
@onready var slice_state: SliceState = get_node_or_null(slice_state_path)
@onready var audio_director: MusicDirector = get_node_or_null(audio_director_path)


func _ready() -> void:
	if player != null:
		player.call_requested.connect(_on_player_call_requested)


func _process(delta: float) -> void:
	if current_phase == Phase.IDLE or current_phase == Phase.RESOLVED:
		return

	_phase_elapsed += delta
	if _phase_elapsed >= float(_phase_durations.get(current_phase, INF)):
		if current_phase == Phase.SPATIAL_CHOICE:
			_resolve_from_position()
		else:
			_advance_phase()


func start_sequence(from_wrong_route: bool) -> void:
	entry_mode_wrong = from_wrong_route
	_set_phase(Phase.LOADED_APPROACH)


func get_phase_name() -> String:
	match current_phase:
		Phase.LOADED_APPROACH:
			return "Loaded Approach"
		Phase.DOUBLE_CALL_READ:
			return "Double Call Read"
		Phase.HOLD_THE_MIDDLE:
			return "Hold The Middle"
		Phase.SPATIAL_CHOICE:
			return "Spatial Choice"
		Phase.RESOLVED:
			return "Resolved"
		_:
			return "Idle"


func _advance_phase() -> void:
	match current_phase:
		Phase.LOADED_APPROACH:
			_set_phase(Phase.DOUBLE_CALL_READ)
		Phase.DOUBLE_CALL_READ:
			_set_phase(Phase.HOLD_THE_MIDDLE)
		Phase.HOLD_THE_MIDDLE:
			_set_phase(Phase.SPATIAL_CHOICE)


func _set_phase(new_phase: int) -> void:
	current_phase = new_phase
	_phase_elapsed = 0.0
	if audio_director != null:
		if current_phase == Phase.HOLD_THE_MIDDLE or current_phase == Phase.SPATIAL_CHOICE:
			audio_director.pulse_conflict()
	emit_signal("phase_changed", current_phase)


func _on_player_call_requested() -> void:
	if current_phase != Phase.SPATIAL_CHOICE:
		return
	_resolve_from_position()


func _resolve_from_position() -> void:
	if player == null:
		return

	if player.global_position.x <= lawful_threshold_x:
		_apply_outcome(&"lawful_return")
	elif player.global_position.x >= wrong_threshold_x:
		_apply_outcome(&"wrong_home")
	else:
		_apply_outcome(&"broken_middle")


func _apply_outcome(outcome: StringName) -> void:
	if slice_state != null:
		match outcome:
			&"lawful_return":
				slice_state.set_arrival_state(SliceState.ArrivalState.LAWFUL)
				slice_state.set_revisit_flag(&"safer_public_routes")
			&"wrong_home":
				slice_state.set_arrival_state(SliceState.ArrivalState.WRONG_ROUTE)
				slice_state.add_suspicion(1)
				slice_state.set_revisit_flag(&"private_routes_open")
			&"broken_middle":
				slice_state.set_arrival_state(SliceState.ArrivalState.BROKEN_MIDDLE)
				slice_state.add_suspicion(1)
				slice_state.set_revisit_flag(&"routes_unstable")
				if player != null:
					player.enter_split_recovery()

	if audio_director != null:
		audio_director.pulse_conflict()

	_set_phase(Phase.RESOLVED)
	emit_signal("resolution_changed", outcome)