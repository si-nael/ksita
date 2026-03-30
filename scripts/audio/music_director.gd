extends Node
class_name MusicDirector

enum LayerState {
	LAWFUL,
	THINNING,
	HELD_WRONG,
	LOST,
	CONFLICT,
}

signal layer_changed(new_layer: int)

var current_layer: int = LayerState.LAWFUL


func set_layer(new_layer: int) -> void:
	if new_layer == current_layer:
		return
	current_layer = new_layer
	emit_signal("layer_changed", current_layer)


func pulse_conflict() -> void:
	set_layer(LayerState.CONFLICT)


func get_layer_name() -> String:
	match current_layer:
		LayerState.LAWFUL:
			return "Lawful"
		LayerState.THINNING:
			return "Thinning"
		LayerState.HELD_WRONG:
			return "Held Wrong"
		LayerState.LOST:
			return "Lost"
		LayerState.CONFLICT:
			return "Conflict"
		_:
			return "Unknown"