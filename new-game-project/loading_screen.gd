extends CanvasLayer

@export var next_scene_path: String

func _ready():
	randomize()
	var tips = [
		"Tip: Press TAB to switch your sword.",
		"Tip: Press Q to use your potions."
	]
	var random_tip = tips[randi() % tips.size()]
	$Tips.text = random_tip
	await get_tree().create_timer(1.5).timeout
	var new_scene = load(next_scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene.free()
	get_tree().current_scene = new_scene
	queue_free()
