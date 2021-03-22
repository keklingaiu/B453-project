extends Node

class_name LevelWalker

const moveableDirections = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borderOfMap = Rect2()

var step_history = []
var steps_since_turn = 0

func _init(start_pos, new_borders):
	assert(new_borders.has_point(start_pos))
	position = start_pos
	step_history.append(position)
	borderOfMap = new_borders
	
	
func step():
	var target_pos = position + direction
	if borderOfMap.has_point(target_pos):
		steps_since_turn += 1
		position = target_pos
		return true
	else:
		return false
	
func switch_dir():
	steps_since_turn = 0
	var directions = moveableDirections.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borderOfMap.has_point(position + direction):
		direction = directions.pop_front()
