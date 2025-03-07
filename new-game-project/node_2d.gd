extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var aim_direction := Vector2.ZERO
	aim_direction = global_position.direction_to(get_global_mouse_position())
	if aim_direction.length() > 0.1:
		rotation = aim_direction.angle()
