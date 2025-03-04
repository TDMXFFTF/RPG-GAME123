class_name Player extends CharacterBody2D

@export var speed := 400
@export var drag_factor := 12.0


func _physics_process(delta: float) -> void:
	var move_direction := Input.get_vector("left", "right", "up", "down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	var direction_discrete := move_direction.sign()
	move_and_slide()
