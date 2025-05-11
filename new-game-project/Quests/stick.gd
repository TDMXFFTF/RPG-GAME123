extends Area2D

@export var quest : Quest_1

var pickup = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if pickup == 3:
		print("WWAWDOWFOIEWJOEJGOIWEJG")


func _on_area_entered(_area: Area2D) -> void:
	quest.stick_collected()
	queue_free()
	
