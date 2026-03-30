extends Node2D
class_name WitnessRouteSegment

enum RouteState {
	HELD_TRUE,
	THINNING,
	HELD_WRONG,
	LOST,
}

signal route_state_changed(new_state: int)

@export var segment_name: String = "Route Segment"

var current_state: int = RouteState.LOST

@onready var bridge_line: Line2D = $BridgeLine
@onready var state_label: Label = $StateLabel


func apply_tether_state(tether_state: int) -> void:
	match tether_state:
		0:
			set_state(RouteState.HELD_TRUE)
		1:
			set_state(RouteState.THINNING)
		2:
			set_state(RouteState.HELD_WRONG)
		_:
			set_state(RouteState.LOST)


func set_state(new_state: int) -> void:
	if new_state == current_state:
		return
	current_state = new_state
	_update_visuals()
	emit_signal("route_state_changed", current_state)


func get_state_name() -> String:
	match current_state:
		RouteState.HELD_TRUE:
			return "Held True"
		RouteState.THINNING:
			return "Thinning"
		RouteState.HELD_WRONG:
			return "Held Wrong"
		RouteState.LOST:
			return "Lost"
		_:
			return "Unknown"


func _ready() -> void:
	_update_visuals()


func _update_visuals() -> void:
	var color := Color(0.38, 0.42, 0.50)
	match current_state:
		RouteState.HELD_TRUE:
			color = Color(0.76, 0.90, 1.0)
		RouteState.THINNING:
			color = Color(0.96, 0.80, 0.48)
		RouteState.HELD_WRONG:
			color = Color(0.92, 0.52, 0.82)
		RouteState.LOST:
			color = Color(0.35, 0.38, 0.48)
	bridge_line.default_color = color
	state_label.text = "%s | %s" % [segment_name, get_state_name()]
	state_label.modulate = color