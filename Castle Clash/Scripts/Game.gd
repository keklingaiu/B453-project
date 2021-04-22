extends Node2D

const Player = preload("res://Player/Player.tscn")
const Exit = preload("res://ExitButton/ExitButton.tscn")
const Enemy = preload("res://Enemy/Enemy.tscn")


onready var tileMap = $Walls

var borders = Rect2(1, 1, 37, 20)
var stepsToWalk = 500

var startTime = OS.get_time()
var endTime = OS.get_time()

var currentBestTime = "Best Time: "

var serverSeed = 0

var enemyCount = 7

	
	
func create_level():
	Server.requestBestTime(get_instance_id())
	var levelWalker = LevelWalker.new(Vector2(18, 10), borders, serverSeed)
	var level = levelWalker.walk(stepsToWalk)
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = levelWalker.grab_last_room().position * 32
	exit.connect("enter_next_lvl", self, "reload_level")
	
	var player = Player.instance()
	add_child(player)
	player.position = level.front() * 32
	
	
#	for e in enemyCount:
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = levelWalker.rooms[int(rand_range(0,10))].position
		
	
	
	levelWalker.queue_free()
	for location in level:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)
	
	startTime = OS.get_time()
	
func reload_level():
	endTime = OS.get_time()
	
	var timeTook = {"hour": abs(endTime.hour - startTime.hour), "minute": abs(endTime.minute - startTime.minute), "second": abs(endTime.second - startTime.second)}
	Server.SendTime(get_instance_id(), timeTook)
	get_tree().reload_current_scene()
	Server.requestBestTime(get_instance_id())



func setSeed(newSeed):
	serverSeed = newSeed
	seed(newSeed)
	


func setTime(s_time):
	print("Received time")
	print(s_time)
	if(s_time == null):
		currentBestTime = "Best Time: none"
	else:
		currentBestTime = "Best Time: " + s_time.hour + ":" + s_time.minute + ":" + s_time.second
	print(currentBestTime)
	
	

func _on_Server_connected():
	Server.requestSeed(get_instance_id())
	
	create_level()
	
