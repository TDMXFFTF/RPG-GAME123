extends CanvasLayer


var active := true

func _ready():
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.name == "MainMenu":
		active = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
