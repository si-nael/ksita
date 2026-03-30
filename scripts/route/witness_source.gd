extends Area2D
class_name WitnessSource

enum WitnessKind {
	LAWFUL,
	FALSE,
	HOSTILE,
}

@export var witness_kind: WitnessKind = WitnessKind.LAWFUL
@export var source_strength: float = 1.0
@export var cadence_name: String = "lawful"
@export var cue_color: Color = Color(0.76, 0.90, 1.0)

@onready var visual: Polygon2D = $Visual
@onready var label: Label = $Label


func _ready() -> void:
	if visual != null:
		visual.color = cue_color
	if label != null:
		label.text = "%s\n%s" % [get_kind_name(), cadence_name]
		label.modulate = cue_color


func is_lawful() -> bool:
	return witness_kind == WitnessKind.LAWFUL


func is_false() -> bool:
	return witness_kind == WitnessKind.FALSE


func get_kind_name() -> String:
	match witness_kind:
		WitnessKind.LAWFUL:
			return "Lawful"
		WitnessKind.FALSE:
			return "False"
		WitnessKind.HOSTILE:
			return "Hostile"
		_:
			return "Unknown"