extends StaticBody2D

@onready var first_actionable := $Actionable
@onready var second_actionable := $Actionable2
@export var first_dialog : DialogueResource;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


signal quest_menu_closed
var quest_test_active = false
var quest_test_completed = false
var object = 0

func quest_chat():
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
