extends Node2D
class_name BossProjectile

@onready var hit_box = $Area2D/HitBox
@export var projectile_scene: PackedScene
@onready var projectile = %Projectile

@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var random_angle := PI / 12.0
@export_range(100.0, 2000.0, 1.0) var RANGE := 2000.0
@export_range(100.0, 3000.0, 1.0) var bullet_speed := 1500.0


func _on_body_entered(body: Node) -> void:
	if body is Player:
		shoot()

func shoot() -> void:
	if not projectile_scene:
		push_error("Projectile scene not assigned!")
		return

	# Instantiate the projectile
	var new_projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(new_projectile)

	# Set the position of the projectile
	new_projectile.global_position = global_position

	# Calculate the direction to the player
	var player = get_node("/root/Player")  # Adjust the path to the player node
	if player:
		var direction_to_player = (player.global_position - new_projectile.global_position).normalized()

		# Set the rotation to point toward the player
		new_projectile.rotation = direction_to_player.angle()

		# Set the velocity of the projectile
		if new_projectile.has_method("set_velocity"):
			new_projectile.set_velocity(direction_to_player * bullet_speed)
	else:
		push_error("Player not found!")
