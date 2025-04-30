class_name MobSpawn extends Node2D


@export var mob_scene: PackedScene = preload("res://mob.tscn")
@export var spawn_area: Rect2 = Rect2(Vector2.ZERO, Vector2(42.263, 37.865))
@export var spawn_interval: float = 1.0
@export var stop_after: float = 5.0

func _ready():
	#randomize()

	if $SpawnTimer and $StopTimer:
		$SpawnTimer.wait_time = spawn_interval
		$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)

		$StopTimer.wait_time = stop_after
		$StopTimer.one_shot = true
		$StopTimer.timeout.connect(_on_stop_timer_timeout)
	else:
		push_error("SpawnTimer or StopTimer is missing from the scene!")

func spawn_all_mobs():
	$SpawnTimer.start()
	$StopTimer.start()

func _on_spawn_timer_timeout() -> void:
	spawn_mob()

func _on_stop_timer_timeout() -> void:
	$SpawnTimer.stop()
	print("Stopped spawning mobs.")

func spawn_mob():
	if not mob_scene:
		print("Mob scene not assigned!")
		return

	var mob = mob_scene.instantiate()

	var spawn_x = randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
	var spawn_y = randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	mob.position = Vector2(spawn_x, spawn_y)

	# Assign the player to the mob
	var player = get_tree().current_scene.get_node("Player")  # Adjust path if necessary
	if player and mob.has_method("set_player"):
		mob.set_player(player)
	else:
		print("Could not assign player to mob.")

	print("Spawning mob at:", mob.position)
	get_tree().current_scene.add_child(mob)
