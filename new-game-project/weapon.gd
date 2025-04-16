extends Node2D
class_name Weapon

@export var damage := 1.0  # Default damage for base weapon
@export var attack_speed := 1.0
@onready var animation_player = %AnimationPlayer
@onready var hit_box = %HitBox

var attack_active := false
var hit_mobs: Array = []

func _ready() -> void:
	hit_box.body_entered.connect(_on_hit_box_body_entered)
	animation_player.animation_finished.connect(_on_attack_finished)

func _process(_delta: float) -> void:
	if not is_visible_in_tree():
		return

	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	rotation = mouse_direction.angle()

	if scale.y == 1 and mouse_direction.x < 0:
		scale.y = -1
	elif scale.y == -1 and mouse_direction.x > 0:
		scale.y = 1

	if Input.is_action_just_pressed("attack") and not animation_player.is_playing():
		start_attack()

func start_attack():
	animation_player.play("sword")
	attack_active = true
	hit_mobs.clear()
	await get_tree().create_timer(attack_speed).timeout  # Adjust the timer based on attack speed
	attack_active = false

func _on_attack_finished(anim_name: String) -> void:
	attack_active = false
	hit_mobs.clear()

func _on_hit_box_body_entered(body: Node) -> void:
	if not attack_active:
		return

	if body is Mob and body not in hit_mobs:
		hit_mobs.append(body)
		if body.has_method("take_damage"):
			body.take_damage(damage)
