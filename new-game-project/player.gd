class_name Player extends CharacterBody2D

enum {UP, DOWN}

@export var speed := 400
@export var drag_factor := 12.0
@export var max_health := 10
@export var current_item : Item:
	set(value):
		current_item = value
var current_weapon: Node2D
@onready var _health_bar: ProgressBar = %HealthBar
@onready var weapons = %Weapons


var health := max_health: set = set_health

func _ready() -> void:
	_health_bar.max_value = max_health
	_health_bar.value = health
	_health_bar.init_health(health)
	current_weapon = weapons.get_child(0)

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position.normalized())

func _physics_process(delta: float) -> void:
	var move_direction := Input.get_vector("left", "right", "up", "down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	var direction_discrete := move_direction.sign()
	move_and_slide()

func get_input() -> void:
	if not current_weapon.is_busy():
		if Input.is_action_just_released("previous_weapon"):
			_switch_weapon(UP)
		elif Input.is_action_just_released("next_weapon"):
			_switch_weapon(DOWN)
	current_weapon.get_input()

func _switch_weapon(direction: int) -> void:
	var index: int = current_weapon.get_index()
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()

func set_health(new_health: int) -> void:
	var previous_health := health
	health = clampi(new_health, 0, max_health)
	_health_bar.value = health
	if health == 0:
		queue_free()
	_health_bar.health = health
