extends Node
class_name FocusReader


func describe_route_state(route_state_name: String, is_focusing: bool) -> String:
	if is_focusing:
		return "%s | Focused" % route_state_name
	return "%s | Unfocused" % route_state_name