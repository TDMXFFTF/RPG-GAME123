extends Node2D
class_name BossProjectile

@onready var hit_box = $Area2D/HitBox
@onready var projectile_detection = $Area2D/ProjectileDetection  # Reference to the Area2D node for detection
@export var projectile_scene: PackedScene
@onready var projectile = %Projectile
@onready var shoot_timer = $ShootTimer

@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var random_angle := PI / 12.0
@export_range(100.0, 2000.0, 1.0) var RANGE := 2000.0
@export_range(100.0, 3000.0, 1.0) var bullet_speed := 1500.0

var velocity = Vector2.ZERO  # Store velocity to update position

func _ready():
	shoot_timer.timeout.connect(shoot)  # Connect the timer to the shoot function

	# Connect detection for when the projectile hits a body (e.g., Player)

	# Set the initial rotation or position
	rotation += random_angle  # Add randomness to the projectile's initial angle

func _on_body_entered(body: Node) -> void:
	# Only shoot if the body is the player
	if body is Player:
		shoot()

func shoot() -> void:
	if not projectile_scene:
		push_error("Projectile scene not assigned!")
		return

	# Instantiate the projectile from the scene
	var new_projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(new_projectile)
	new_projectile.global_position = global_position  # Set the starting position of the projectile

	# Get the player node and calculate direction
	var player = get_tree().root.get_node("Background/Player")
	if player:
		var direction_to_player = (player.global_position - new_projectile.global_position).normalized()
		new_projectile.rotation = direction_to_player.angle()

		# Set the velocity to move towards the player
		if new_projectile.has_method("set_velocity"):
			new_projectile.set_velocity(direction_to_player * bullet_speed)
	else:
		push_error("Player not found!")

# If needed, update the projectile's position here
func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		position += velocity * delta
