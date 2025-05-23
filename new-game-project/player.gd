class_name Player extends CharacterBody2D


@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var explosion_sound_effects: AudioStreamPlayer = $ExplosionSoundEffects
@onready var timer: Timer = $Timer


@export var speed := 400
@export var drag_factor := 12.0
@export var max_health := 10
var inventory: Node
@export var current_item : Item:
	set(value):
		current_item = value
		_equip_weapon_from_item(value)
var current_weapon: Node2D
@onready var _health_bar = $CanvasLayer/HealthBar

@onready var weapons = %Weapons


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_death: AnimationPlayer = $AnimationDeath




var death = false
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

	inventory = InventoryUI.get_node("Manager/Inventory")

	$AnimatedSprite2D.play("down_idle")

	if inventory:
		inventory.load_inventory()
		inventory.character.reapply_equipped_item()
	else:
		print("Inventory not found in Autoload")


func _on_inventory_ready():
	State.inventory.load_inventory()

func _physics_process(delta: float) -> void:
	if death == false:
		var move_direction := Input.get_vector("left", "right", "up", "down")
		var desired_velocity := speed * move_direction
		var steering := desired_velocity - velocity
		velocity += steering * drag_factor * delta
		var _direction_discrete := move_direction.sign()
		move_and_slide()

		if Input.is_action_pressed("down"):
			$AnimatedSprite2D.play("down_walk")
		if Input.is_action_just_released("down"):
			$AnimatedSprite2D.play("down_idle")

		if Input.is_action_pressed("up"):
			$AnimatedSprite2D.play("up_walk")
		if Input.is_action_just_released("up"):
			$AnimatedSprite2D.play("up_idle")

		if Input.is_action_pressed("left"):
			$AnimatedSprite2D.play("left_walk")
		if Input.is_action_just_released("left"):
			$AnimatedSprite2D.play("left_idle")

		if Input.is_action_pressed("right"):
			$AnimatedSprite2D.play("right_walk")
		if Input.is_action_just_released("right"):
			$AnimatedSprite2D.play("right_idle")



	#print(PotionManager.potions)
	if Input.is_action_just_pressed("potion_use"):
		if health < 10:
			if PotionManager.potions > 0:
				health += 3
				PotionManager.potions -= 1



func _equip_weapon_from_item(item: Item) -> void:
	for weapon in weapons.get_children():
		weapon.hide()
		weapon.set_process(false)

	if item == null:
		current_weapon = null
		return

	for weapon in weapons.get_children():
		if weapon.name == item.weapon_scene_name:
			current_weapon = weapon
			weapon.show()
			weapon.set_process(true)


func equip(item: Item):
	current_item = item  
	for weapon in $Weapons.get_children():
		weapon.hide()
		weapon.set_process(false)

	if item == null:
		current_weapon = null
		return

	for weapon in $Weapons.get_children():
		if weapon.name == item.weapon_scene_name:
			weapon.show()
			weapon.set_process(true)
			current_weapon = weapon



func set_health(new_health: int) -> void:
	var _previous_health := health
	if death == false:
		health = clampi(new_health, 0, max_health)
		_health_bar.value = health
		_health_bar.health = health
	if health <= 0:
		death = true
		$AnimatedSprite2D.play("yes_dead")
		timer.start()
		explosion_sound_effects.play()
		print("oops")
		
		




func _on_timer_timeout():
	get_node("GamingIsOver").game_over()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			for actionable in actionables:
				if (actionable is Actionable):
					actionable.action()
