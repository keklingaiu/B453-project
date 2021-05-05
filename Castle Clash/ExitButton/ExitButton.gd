extends Area2D

signal enter_next_lvl

func _on_ExitButton_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("enter_next_lvl")
