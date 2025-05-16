extends Node2D
class_name Quest_3

var kill = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mob2_killed() -> void:
	kill += 1
	if kill == 20:
		State.state_quest = "finished3"
