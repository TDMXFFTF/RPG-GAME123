class_name Player extends CharacterBody2D

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

@export var speed := 400
@export var drag_factor := 12.0


func _physics_process(delta: float) -> void:
	var move_direction := Input.get_vector("left", "right", "up", "down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	var direction_discrete := move_direction.sign()
	move_and_slide()
	if Input.is_action_just_pressed("right"):
		$AnimationPlayer.play("right")
	elif Input.is_action_just_pressed("left"):
		$AnimationPlayer.play("left")
	elif Input.is_action_just_pressed("up"):
		$AnimationPlayer.play("UP")
	elif Input.is_action_just_pressed("down"):
		$AnimationPlayer.play("DoWn")


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"),"start")
			return
