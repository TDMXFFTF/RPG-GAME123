extends Area2D

@export var dialouge_resource: DialogueResource
@export var dialouge_start2: String = "start2nd"


func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialouge_resource,dialouge_start2)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
