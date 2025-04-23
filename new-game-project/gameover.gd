extends CanvasLayer

func _ready() -> void:
	self.hide()

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	if PotionManager.potions > 0:
		PotionManager.potions = 0


func game_over():
	get_tree().paused = true
	self.show()
