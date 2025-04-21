extends Area2D

@export var dialouge_resource: DialogueResource
@export var dialouge_start: String = "start"

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialouge_resource,dialouge_start)
