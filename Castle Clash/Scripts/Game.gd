extends Node2D

const Player = preload("res://Player/Player.tscn")
const Exit = preload("res://ExitButton/ExitButton.tscn")

onready var tileMap = $Walls

var borders = Rect2(1, 1, 37, 20)
var stepsToWalk = 500

var realTime = OS.get_time()
	
#func _ready():
#	create_level()
	
func create_level():
	var levelWalker = LevelWalker.new(Vector2(18, 10), borders)
	var level = levelWalker.walk(stepsToWalk)
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = levelWalker.grab_last_room().position * 32
	exit.connect("enter_next_lvl", self, "reload_level")
	
	var player = Player.instance()
	add_child(player)
	player.position = level.front() * 32
	
	
	levelWalker.queue_free()
	for location in level:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)
	
func reload_level():
	get_tree().reload_current_scene()	



func setSeed(newSeed):
	return newSeed
	
	


func _on_Server_connected():
	Server.requestSeed(get_instance_id())
	create_level()
