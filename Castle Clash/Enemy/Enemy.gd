extends KinematicBody2D

const Player = preload("res://Player/Player.tscn")



#func _physics_process(delta):
#	var player = get_parent().get_node("Player")
#
#	position += (player.position - position)/50
#	look_at(player.position)
#
#	move = move_and_slide(move) 

#var player = null
#
#var move = Vector2.ZERO
#var moveSpeed = 1
#
#func _physics_process(delta):
#	move = Vector2.ZERO
#	if player != null:
#		move = position.direction_to(player.position) * moveSpeed
#	else:
#		move = Vector2.ZERO
#
#	move.normalized()
#	move = move_and_slide(move)
#
#
#func _on_Area2D_body_entered(body):
#	if body.is_in_group("Player"):
#		look_at(Player.position)
#
#
#func _on_Area2D_body_exited(body):
#	player = null


var run_speed = 72
var velocity = Vector2.ZERO
var player = null

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
		look_at(player.position)
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null
