extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_start_dialogue")

func _start_dialogue():
	DialogueManager.show_example_dialogue_balloon(load("res://final.dialogue"), "start")

func change_to_boss():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
