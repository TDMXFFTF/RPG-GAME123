class_name Mob extends CharacterBody2D


@export var SPEED := 250.0
@export var acceleration := 450.0
@export var drag_factor := 1.5
@export var max_health := 3
@export var damage := 1
var _player: Player = null
var health := max_health
@onready var _detection: Area2D = %Detection
@onready var _hit_box: Area2D = %HitBox
@onready var _damage_timer: Timer = %DamageTimer
@onready var _health_bar: ProgressBar = %HealthBar

func _ready() -> void:
	_detection.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	_detection.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
	)
	_hit_box.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			body.health -= damage
			_damage_timer.start()
	)
	_hit_box.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_damage_timer.stop()
	)
	_damage_timer.timeout.connect(func () -> void:
		_player.health -= damage
	)
	health = max_health
	_health_bar.max_value = max_health
	_health_bar.value = health
	_health_bar.init_health(health)

# Set the player reference from the MobSpawner
func set_player(player: Player) -> void:
	_player = player

func _physics_process(delta: float) -> void:
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		var direction := global_position.direction_to(get_global_player_position())
		var distance := global_position.distance_to(get_global_player_position())
		var speed := SPEED if distance > 110.0 else SPEED * distance / 110.0

		var desired_velocity := direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		move_and_slide()

func get_global_player_position() -> Vector2:
	# Return the global position of the player
	if _player:
		return _player.global_position
	else:
		return global_position  # If no player, fallback to the mob's current position

func take_damage(amount: float) -> void:
	health -= amount

func set_health(new_health: int) -> void:
	var previous_health := health
	health = clampi(new_health, 0, max_health)
	_health_bar.value = health
	if health == 0:
		queue_free()
	_health_bar.health = health
