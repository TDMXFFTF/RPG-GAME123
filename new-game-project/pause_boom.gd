extends CanvasLayer



func _ready() -> void:
	self.hide()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		self.show()
		get_tree().paused = true

	

func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.hide()


func _on_quit_noww_pressed() -> void:
	get_tree().quit()
