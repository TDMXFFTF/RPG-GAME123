extends CanvasLayer

func show_message(text: String, duration := 1.5):
	$QuestMessage.text = text
	$QuestMessage.visible = true
	await get_tree().create_timer(duration).timeout
	$QuestMessage.visible = false
