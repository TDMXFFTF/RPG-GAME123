class_name Player extends CharacterBody2D

@export var speed := 400
@export var drag_factor := 12.0
@export var max_health := 10
var inventory: Node
@export var current_item : Item:
	set(value):
		current_item = value
		_equip_weapon_from_item(value)
var current_weapon: Node2D
@onready var _health_bar: ProgressBar = %HealthBar
@onready var weapons = %Weapons


var health := max_health: set = set_health

func _ready() -> void:
	_health_bar.max_value = max_health
	_health_bar.value = health
	_health_bar.init_health(health)

	current_weapon = weapons.get_child(0)
	for weapon in %Weapons.get_children():
		weapon.hide()
		weapon.set_process(false)

	await get_tree().process_frame 

	inventory = get_tree().get_current_scene().get_node("Manager/Inventory")

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position.normalized())

func _physics_process(delta: float) -> void:
	var move_direction := Input.get_vector("left", "right", "up", "down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	velocity += steering * drag_factor * delta
	var direction_discrete := move_direction.sign()
	move_and_slide()

func _equip_weapon_from_item(item: Item) -> void:
	for weapon in weapons.get_children():
		weapon.hide()
		weapon.set_process(false)
		if weapon.name == item.weapon_scene_name:
			current_weapon = weapon
			weapon.show()
			weapon.set_process(true)

func equip(item: Item):
	current_item = item  
	for weapon in $Weapons.get_children():
		weapon.hide()
		weapon.set_process(false)
		if weapon.name == item.weapon_scene_name:
			weapon.show()
			weapon.set_process(true)
			current_weapon = weapon


func set_health(new_health: int) -> void:
	var previous_health := health
	health = clampi(new_health, 0, max_health)
	_health_bar.value = health
	if health == 0:
		queue_free()
	_health_bar.health = health
