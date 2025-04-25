extends Area2D
class_name Projectile

@export var speed := 750
@export var max_range := 1000.0
@onready var hit_box = $HitBox

var _traveled_distance = 0.0
var velocity = Vector2.ZERO  # Store the velocity of the projectile

func _ready():
	# Set the initial velocity based on the direction (from BossProjectile)
	velocity = Vector2.RIGHT.rotated(rotation) * speed

func _physics_process(delta: float) -> void:
	# Move the projectile according to its velocity
	position += velocity * delta

	# Track how far the projectile has traveled
	_traveled_distance += velocity.length() * delta
	if _traveled_distance > max_range:
		_destroy()

# Destroy the projectile once it's out of range
func _destroy():
	queue_free()
