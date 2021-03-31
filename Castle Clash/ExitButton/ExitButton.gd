extends Area2D

signal enter_next_lvl

func _on_ExitButton_body_entered(body):
	emit_signal("enter_next_lvl")
