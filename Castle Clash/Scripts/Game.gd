extends Node2D

onready var tileMap = $Walls

var borders = Rect2(1, 1, 37, 20)
var stepsToWalk = 800

#var realTime = OS.get_time()

#var path = "user://time.json"


	
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
	
	
	

	

