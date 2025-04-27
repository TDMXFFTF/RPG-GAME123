extends Mob

@export var projectile_scene: PackedScene
@export var detection_scale: float = 2.0
@onready var projectile_detection: Area2D = %ProjectileDetection
@onready var _projectile_timer: Timer = Timer.new()

func _ready() -> void:
	super._ready()
	var shape = %Detection.get_node("CollisionShape2D").shape
	if shape is CircleShape2D:
		shape.radius *= detection_scale
	elif shape is RectangleShape2D:
		shape.extents *= Vector2(detection_scale, detection_scale)
	add_child(_projectile_timer)
	_projectile_timer.wait_time = 2.0
	_projectile_timer.one_shot = false

	projectile_detection.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_projectile_timer.start()
	)
	projectile_detection.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_projectile_timer.stop()
	)

	_projectile_timer.timeout.connect(_shoot_projectile)

func _shoot_projectile() -> void:
	var player = get_tree().root.get_node("Background/Player") as Player
	if player == null:
		return

	var projectile = projectile_scene.instantiate() as Area2D
	projectile.global_position = global_position
	projectile.direction = (player.global_position - global_position).normalized()
	get_tree().root.add_child(projectile)
