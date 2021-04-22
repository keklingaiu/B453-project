extends KinematicBody2D

const Player = preload("res://Player/Player.tscn")

var move = Vector2()
var moveSpeed = 70

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	
	position += (player.position - position)/50
	look_at(player.position)
	
	move = move_and_slide(move) 

