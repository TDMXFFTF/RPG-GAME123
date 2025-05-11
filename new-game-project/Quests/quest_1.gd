extends Node2D
class_name Quest_1 

var pickup = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func stick_collected() -> void:
	pickup += 1
	if pickup >= 3:
		print("compledt!")
		State.state_quest = "done1"
