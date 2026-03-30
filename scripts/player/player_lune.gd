extends CharacterBody2D
class_name PlayerLune

signal focus_changed(is_active: bool)
signal carry_state_changed(is_active: bool)
signal call_requested()
signal answer_used(role_name: StringName)
signal knot_used()
signal cut_used()

@export var run_speed: float = 280.0
@export var carry_speed: float = 236.0
@export var focus_speed: float = 218.0
@export var carry_focus_speed: float = 190.0

@export var quick_step_distance: float = 84.0
@export var quick_step_duration: float = 0.15
@export var quick_step_cooldown: float = 0.60

@export var carry_quick_step_distance: float = 60.0
@export var carry_quick_step_duration: float = 0.17
@export var carry_quick_step_cooldown: float = 0.75

@export var split_recovery_duration: float = 2.40

var is_focusing: bool = false
var is_carrying: bool = false
var split_recovery_time: float = 0.0

var _quick_step_timer: float = 0.0
var _quick_step_cooldown_timer: float = 0.0
var _quick_step_lock_timer: float = 0.0
var _quick_step_direction: Vector2 = Vector2.RIGHT

@onready var body_visual: Polygon2D = $Body
@onready var shadow_visual: Polygon2D = $Shadow
@onready var state_label: Label = $StateLabel


func _ready() -> void:
	_install_input_actions()
	_update_visuals()


func _physics_process(delta: float) -> void:
	is_focusing = Input.is_action_pressed("focus")
	_quick_step_cooldown_timer = max(0.0, _quick_step_cooldown_timer - delta)
	_quick_step_lock_timer = max(0.0, _quick_step_lock_timer - delta)

	if split_recovery_time > 0.0:
		split_recovery_time = max(0.0, split_recovery_time - delta)

	if _quick_step_timer > 0.0:
		_quick_step_timer = max(0.0, _quick_step_timer - delta)
		velocity = _quick_step_direction * _get_quick_step_speed()
	else:
		var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_vector != Vector2.ZERO:
			_quick_step_direction = input_vector.normalized()
		velocity = input_vector * _get_move_speed()
		if Input.is_action_just_pressed("quick_step") and _quick_step_cooldown_timer <= 0.0 and _quick_step_lock_timer <= 0.0:
			_start_quick_step()

	move_and_slide()
	_update_visuals()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("call"):
		emit_signal("call_requested")
	elif event.is_action_pressed("answer"):
		emit_signal("answer_used", StringName("sanctioned_runner"))
	elif event.is_action_pressed("knot"):
		emit_signal("knot_used")
	elif event.is_action_pressed("cut"):
		emit_signal("cut_used")


func set_carrying(value: bool) -> void:
	if is_carrying == value:
		return
	is_carrying = value
	emit_signal("carry_state_changed", is_carrying)
	_update_visuals()


func enter_split_recovery(duration: float = -1.0) -> void:
	split_recovery_time = split_recovery_duration if duration < 0.0 else duration
	_quick_step_lock_timer = 0.65
	_update_visuals()


func end_split_recovery() -> void:
	split_recovery_time = 0.0
	_update_visuals()


func _start_quick_step() -> void:
	_quick_step_timer = carry_quick_step_duration if is_carrying else quick_step_duration
	_quick_step_cooldown_timer = carry_quick_step_cooldown if is_carrying else quick_step_cooldown


func _get_move_speed() -> float:
	if is_carrying and is_focusing:
		return carry_focus_speed
	if is_carrying:
		return carry_speed
	if is_focusing:
		return focus_speed
	return run_speed


func _get_quick_step_speed() -> float:
	var distance := carry_quick_step_distance if is_carrying else quick_step_distance
	var duration := carry_quick_step_duration if is_carrying else quick_step_duration
	return distance / max(duration, 0.01)


func _update_visuals() -> void:
	var body_color := Color(0.79, 0.87, 0.98)
	var shadow_color := Color(0.08, 0.10, 0.16, 0.80)
	var state_parts: Array[String] = []

	if is_carrying:
		body_color = Color(0.90, 0.80, 0.58)
		state_parts.append("Carry")
	if is_focusing:
		body_color = body_color.lerp(Color(0.64, 0.93, 1.0), 0.35)
		state_parts.append("Focus")
		emit_signal("focus_changed", true)
	else:
		emit_signal("focus_changed", false)
	if split_recovery_time > 0.0:
		body_color = body_color.lerp(Color(0.92, 0.56, 0.86), 0.55)
		shadow_color = Color(0.20, 0.07, 0.24, 0.88)
		state_parts.append("Split")

	body_visual.color = body_color
	shadow_visual.color = shadow_color
	shadow_visual.position = Vector2(10, 12) if split_recovery_time > 0.0 else Vector2(6, 8)
	state_label.text = " | ".join(state_parts) if not state_parts.is_empty() else "Run"


func _install_input_actions() -> void:
	_add_key_action("move_left", KEY_A)
	_add_key_action("move_right", KEY_D)
	_add_key_action("move_up", KEY_W)
	_add_key_action("move_down", KEY_S)
	_add_key_action("quick_step", KEY_SHIFT)
	_add_key_action("answer", KEY_Q)
	_add_key_action("knot", KEY_E)
	_add_key_action("cut", KEY_F)
	_add_key_action("call", KEY_SPACE)
	_add_mouse_action("focus", MOUSE_BUTTON_RIGHT)


func _add_key_action(action_name: StringName, keycode: Key) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	if _action_has_key(action_name, keycode):
		return
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	InputMap.action_add_event(action_name, event)


func _add_mouse_action(action_name: StringName, button: MouseButton) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	if _action_has_mouse_button(action_name, button):
		return
	var event := InputEventMouseButton.new()
	event.button_index = button
	InputMap.action_add_event(action_name, event)


func _action_has_key(action_name: StringName, keycode: Key) -> bool:
	for event in InputMap.action_get_events(action_name):
		if event is InputEventKey and event.physical_keycode == keycode:
			return true
	return false


func _action_has_mouse_button(action_name: StringName, button: MouseButton) -> bool:
	for event in InputMap.action_get_events(action_name):
		if event is InputEventMouseButton and event.button_index == button:
			return true
	return false