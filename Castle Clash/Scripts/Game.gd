extends Node2D

const Player = preload("res://Player/Player.tscn")
const Exit = preload("res://ExitButton/ExitButton.tscn")

onready var tileMap = $Walls

var borders = Rect2(1, 1, 37, 20)
var stepsToWalk = 500

#var realTime = OS.get_time()

#var path = "user://time.json"

func _ready():
	randomize()
	create_level()
	
func create_level():
	var levelWalker = LevelWalker.new(Vector2(18, 10), borders)
	var level = levelWalker.walk(stepsToWalk)
	
	var player = Player.instance()
	add_child(player)
	player.position = level.front() * 32
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = levelWalker.rooms.back().position * 32
	exit.connect("enter_next_lvl", self, "reload_level")
	
	levelWalker.queue_free()
	for location in level:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)
	
func reload_level():
	get_tree().reload_current_scene()	
#func save_time():
#	var save_time = File.new()
#	save_time.open(path, File.WRITE)
#	var realTime = OS.get_time()
#	save_time.store_line(to_json(realTime))
#	save_time.close()
#
#func load_time():
#	var save_time = File.new()
#	if not save_time.file_exists(path):
#		return
#	save_time.open(path, File.READ)
#	var text = save_time.get_as_text()
#	print(text)
#	save_time.close()
#	return text
#
#func do_randomize():
#	load_time()
#	randomize()
	
	
	

	

