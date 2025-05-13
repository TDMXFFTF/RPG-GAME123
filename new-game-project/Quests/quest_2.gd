extends Node2D
class_name Quest_2

var kil = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mob_killed() -> void:
	kil += 1
	if kil == 10:
		State.state_quest = "done2"
