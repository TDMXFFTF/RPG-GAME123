extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_pressed():
	State.change_scene_with_loading("res://background.tscn")


func _on_quit_pressed():
	get_tree().quit()
