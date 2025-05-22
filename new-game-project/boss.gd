extends Mob

@export var projectile_scene: PackedScene
var is_dead: bool = false
@onready var projectile_detect: Area2D = %ProjectileDetection
@onready var _projectile_timer: Timer = Timer.new()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boss_health_bar = $CanvasLayer/HealthBar
@onready var timer_dead: Timer = $TimerDead


func _ready() -> void:
	animated_sprite_2d.play("default")
	super._ready()
	add_child(_projectile_timer)
	_projectile_timer.wait_time = 2.0
	_projectile_timer.one_shot = false

	projectile_detect.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
			_projectile_timer.start()
	)
	projectile_detect.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
			_projectile_timer.stop()
	)
	_projectile_timer.timeout.connect(_shoot_projectile)
	health = max_health
	boss_health_bar.max_value = max_health
	boss_health_bar.value = health
	boss_health_bar.init_health(health)

func _shoot_projectile() -> void:
	if _player == null or is_dead:
		return

	var projectile = projectile_scene.instantiate() as Area2D
	projectile.global_position = global_position
	projectile.direction = (_player.global_position - global_position).normalized()
	get_tree().root.add_child(projectile)

func set_health(new_health: int) -> void:
	var _previous_health := health
	health = clampi(new_health, 0, max_health)
	boss_health_bar.value = health
	if health <= 0 and not is_dead:
		is_dead = true
		animated_sprite_2d.play("dead")
		timer_dead.start()
		SPEED = 0.0
		damage = 0.0
		_projectile_timer.stop()  # <- stop the projectile timer too
	boss_health_bar.health = health


func _on_timer_timeout() -> void:
	queue_free()
