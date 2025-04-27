extends Node2D
class_name Weapon

@export var damage := 1.0
@export var attack_speed := 1.0
@onready var animation_player = %AnimationPlayer
@onready var hit_box = %HitBox

var attack_active := false
var hit_mobs: Array = []

func _ready() -> void:
	hit_box.body_entered.connect(_on_hit_box_body_entered)
	animation_player.animation_finished.connect(_on_attack_finished)

func _process(_delta: float) -> void:
	if not is_visible_in_tree() or attack_active:
		return

	update_weapon_direction()

	if Input.is_action_just_pressed("attack") and not attack_active:
		start_attack()

func update_weapon_direction() -> void:
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	rotation = mouse_direction.angle()

	if scale.y == 1 and mouse_direction.x < 0:
		scale.y = -1
	elif scale.y == -1 and mouse_direction.x > 0:
		scale.y = 1

func start_attack():
	attack_active = true
	update_weapon_direction()

	animation_player.speed_scale = attack_speed
	animation_player.play("sword")
	hit_mobs.clear()

	await get_tree().create_timer(1.0 / attack_speed).timeout
	attack_active = false

func check_hits():
	if not attack_active:
		return

	for body in hit_box.get_overlapping_bodies():
		if body is Mob and body not in hit_mobs:
			hit_mobs.append(body)
			if body.has_method("take_damage"):
				body.take_damage(damage)

func _on_attack_finished(anim_name: String) -> void:
	attack_active = false
	hit_mobs.clear()
	update_weapon_direction()

func _on_hit_box_body_entered(body: Node) -> void:
	if not attack_active:
		return

	if body is Mob and body not in hit_mobs:
		hit_mobs.append(body)
		if body.has_method("take_damage"):
			body.take_damage(damage)
