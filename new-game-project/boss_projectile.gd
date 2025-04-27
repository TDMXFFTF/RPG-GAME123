extends Area2D

@export var speed := 800.0
@export var damage := 2

var direction := Vector2.ZERO

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func _on_body_entered(body):
	if body is Player:
		body.health -= damage
		queue_free()
