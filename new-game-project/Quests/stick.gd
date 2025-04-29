extends Area2D

var pickup = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pickup == 3:
		State.state_quest = "has"
		print("WWAWDOWFOIEWJOEJGOIWEJG")


func _on_area_entered(area: Area2D) -> void:
	queue_free()
	pickup += 1
	
