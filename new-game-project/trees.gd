extends Node2D

# Amount to move this node to the right when it's created
const MOVE_OFFSET := 100

func _ready() -> void:
	# Shift this whole node to the right
	position.x += MOVE_OFFSET

	# Play animation on all AnimatedSprite2D children
	for child in get_children():
		if child is AnimatedSprite2D:
			child.play("leaf")
			child.play("move")
