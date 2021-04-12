extends Node

class_name LevelWalker

const moveableDirections = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borderOfMap = Rect2()

var step_history = []
var steps_since_turn = 0

var rooms = []

var randomRoomSize = (randi() % 4+3)

func _init(start_pos, new_borders, serverSeed):
	seed(serverSeed)
	assert(new_borders.has_point(start_pos))
	position = start_pos
	step_history.append(position)
	borderOfMap = new_borders
	
	
func walk(steps):
	place_room(position)
	for step in steps:
		if steps_since_turn >= 9:
			switch_dir()
			
		if step():
			step_history.append(position)
		else:
			switch_dir()
	return step_history
	
func step():
	var target_pos = position + direction
	if borderOfMap.has_point(target_pos):
		steps_since_turn += 1
		position = target_pos
		return true
	else:
		return false
	
func switch_dir():
	place_room(position)
	steps_since_turn = 0
	var directions = moveableDirections.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borderOfMap.has_point(position + direction):
		direction = directions.pop_front()
		
func generate_room(position, size):
	return {position = position, size = size}
	
		
func place_room(position):
	var sizeOfRoom = Vector2(randomRoomSize, randomRoomSize)
	var leftCornerOfRoom = (position - sizeOfRoom/2).ceil()
	rooms.append(generate_room(position, sizeOfRoom))
	for y in sizeOfRoom.y:
		for x in sizeOfRoom.x:
			var newStep = leftCornerOfRoom + Vector2(x, y)
			if borderOfMap.has_point(newStep):
				step_history.append(newStep)
				
func grab_last_room():
	var last_room = rooms.pop_front()
	var start_pos = step_history.front()
	for room in rooms:
		if start_pos.distance_to(room.position) > start_pos.distance_to(last_room.position):
			last_room = room
	return last_room
