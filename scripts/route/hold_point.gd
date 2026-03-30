extends Area2D
class_name HoldPoint

signal hold_reached(body: Node)


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.has_method("end_split_recovery"):
		body.end_split_recovery()
	emit_signal("hold_reached", body)