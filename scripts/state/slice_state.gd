extends Node
class_name SliceState

enum ArrivalState {
	UNKNOWN,
	LAWFUL,
	WRONG_ROUTE,
	BROKEN_MIDDLE,
}

signal suspicion_changed(new_value: int)
signal arrival_state_changed(new_value: int)
signal frayed_bell_thread_changed(has_item: bool)

var suspicion_level: int = 0
var has_frayed_bell_thread: bool = false
var arrival_state: int = ArrivalState.UNKNOWN
var revisit_flags: Dictionary = {}


func add_suspicion(amount: int) -> void:
	set_suspicion_level(suspicion_level + amount)


func set_suspicion_level(new_value: int) -> void:
	new_value = max(0, new_value)
	if new_value == suspicion_level:
		return
	suspicion_level = new_value
	emit_signal("suspicion_changed", suspicion_level)


func set_arrival_state(new_state: int) -> void:
	if new_state == arrival_state:
		return
	arrival_state = new_state
	emit_signal("arrival_state_changed", arrival_state)


func grant_frayed_bell_thread() -> void:
	if has_frayed_bell_thread:
		return
	has_frayed_bell_thread = true
	emit_signal("frayed_bell_thread_changed", has_frayed_bell_thread)


func set_revisit_flag(flag_name: StringName, value: bool = true) -> void:
	revisit_flags[flag_name] = value


func has_revisit_flag(flag_name: StringName) -> bool:
	return bool(revisit_flags.get(flag_name, false))


func get_arrival_state_name() -> String:
	match arrival_state:
		ArrivalState.LAWFUL:
			return "Lawful Return"
		ArrivalState.WRONG_ROUTE:
			return "Wrong Route"
		ArrivalState.BROKEN_MIDDLE:
			return "Broken Middle"
		_:
			return "Unknown"