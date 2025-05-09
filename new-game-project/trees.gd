extends Node2D

@onready var animated_sprite_1 = %Tree1
@onready var animated_sprite_2 = %Tree2
@onready var animated_sprite_3 = %Tree3


func _ready() -> void:
	animated_sprite_1.play("leaf")
	animated_sprite_2.play("move")
	animated_sprite_2.play("leaf3")
	
