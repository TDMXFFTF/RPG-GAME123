extends Mob

@export var projectile_scene: PackedScene
@onready var projectile_detect: Area2D = %ProjectileDetection
@onready var _projectile_timer: Timer = Timer.new()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


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

func _shoot_projectile() -> void:
	if _player == null:
		return

	var projectile = projectile_scene.instantiate() as Area2D
	projectile.global_position = global_position
	projectile.direction = (_player.global_position - global_position).normalized()
	get_tree().root.add_child(projectile)
