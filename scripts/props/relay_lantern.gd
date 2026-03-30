extends Node2D
class_name RelayLantern

enum TetherState {
	CLEAN,
	THINNING,
	HELD_WRONG,
	LOST,
}

signal tether_state_changed(new_state: int)
signal source_changed(new_source: WitnessSource)

@export var clean_range: float = 224.0
@export var warning_range: float = 196.0
@export var occlusion_thinning_time: float = 0.30
@export var occlusion_lost_time: float = 1.20
@export var wrong_source_capture_time: float = 0.45

var carrier: Node2D
var current_source: WitnessSource
var current_state: int = TetherState.LOST

var _occlusion_timer: float = 0.0
var _false_timer: float = 0.0

@onready var tether_line: Line2D = $TetherLine
@onready var glow: Polygon2D = $Glow


func attach_to_carrier(new_carrier: Node2D) -> void:
	carrier = new_carrier
	global_position = carrier.global_position
	_update_tether_line()


func set_source(new_source: WitnessSource) -> void:
	if current_source == new_source:
		return
	current_source = new_source
	_false_timer = 0.0
	_occlusion_timer = 0.0
	_update_tether_line()
	emit_signal("source_changed", current_source)


func force_lost() -> void:
	_occlusion_timer = occlusion_lost_time
	set_state(TetherState.LOST)


func update_tether(delta: float, occluded: bool, false_field: WitnessSource = null) -> void:
	if carrier != null:
		global_position = carrier.global_position
	_update_tether_line()

	if carrier == null or current_source == null:
		set_state(TetherState.LOST)
		return

	var distance_to_source := global_position.distance_to(current_source.global_position)

	if occluded or distance_to_source > clean_range:
		_occlusion_timer += delta
	else:
		_occlusion_timer = max(0.0, _occlusion_timer - delta * 2.5)

	if false_field != null:
		_false_timer += delta * false_field.source_strength
	else:
		_false_timer = max(0.0, _false_timer - delta * 3.0)

	if false_field != null and _false_timer >= wrong_source_capture_time:
		set_state(TetherState.HELD_WRONG)
		return

	if _occlusion_timer >= occlusion_lost_time:
		set_state(TetherState.LOST)
		return

	if _occlusion_timer >= occlusion_thinning_time or distance_to_source > warning_range:
		set_state(TetherState.THINNING)
		return

	if current_source != null and current_source.is_false():
		set_state(TetherState.HELD_WRONG)
		return

	set_state(TetherState.CLEAN)


func get_state_name() -> String:
	match current_state:
		TetherState.CLEAN:
			return "Held True"
		TetherState.THINNING:
			return "Thinning"
		TetherState.HELD_WRONG:
			return "Held Wrong"
		TetherState.LOST:
			return "Lost"
		_:
			return "Unknown"


func set_state(new_state: int) -> void:
	if new_state == current_state:
		return
	current_state = new_state
	_update_visuals()
	emit_signal("tether_state_changed", current_state)


func _ready() -> void:
	_update_visuals()
	_update_tether_line()


func _process(_delta: float) -> void:
	if carrier != null:
		global_position = carrier.global_position
		_update_tether_line()


func _update_visuals() -> void:
	var color := Color(0.38, 0.42, 0.50)
	match current_state:
		TetherState.CLEAN:
			color = Color(0.77, 0.91, 1.0)
		TetherState.THINNING:
			color = Color(0.98, 0.81, 0.47)
		TetherState.HELD_WRONG:
			color = Color(0.92, 0.55, 0.84)
		TetherState.LOST:
			color = Color(0.45, 0.48, 0.56)
	glow.color = color
	tether_line.default_color = color


func _update_tether_line() -> void:
	tether_line.clear_points()
	tether_line.add_point(Vector2.ZERO)
	if current_source == null:
		tether_line.add_point(Vector2.ZERO)
		return
	var target_point := to_local(current_source.global_position)
	tether_line.add_point(target_point)