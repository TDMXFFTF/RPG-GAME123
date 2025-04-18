class_name Player extends CharacterBody2D

@export var speed := 400
@export var drag_factor := 12.0
@export var max_health := 10
@onready var _health_bar: ProgressBar = %HealthBar
@onready var animation_death: AnimationPlayer = $AnimationDeath

var death = false
var health := max_health: set = set_health

func _ready() -> void:
	_health_bar.max_value = max_health
	_health_bar.value = health
	_health_bar.init_health(health)
	


func _physics_process(delta: float) -> void:
	if death == false:
		var move_direction := Input.get_vector("left", "right", "up", "down")
		var desired_velocity := speed * move_direction
		var steering := desired_velocity - velocity
		velocity += steering * drag_factor * delta
		var direction_discrete := move_direction.sign()
		move_and_slide()
	#print(PotionManager.potions)
	if Input.is_action_just_pressed("potion_use"):
		if PotionManager.potions > 0: 
			health += 3.3
			PotionManager.potions -= 1








func set_health(new_health: int) -> void:
	var previous_health := health
	if death == false:
		health = clampi(new_health, 0, max_health)
		_health_bar.value = health
		_health_bar.health = health
	if health == 0:
		death = true
		$AnimationDeath.play("Dying")
