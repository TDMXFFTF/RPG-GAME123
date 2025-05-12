extends GridContainer

@onready var slots = get_children()

func equip(item):
	get_tree().current_scene.find_child("Player").current_item = item

func clear_character():
	for slot in slots:
		slot.item = null
