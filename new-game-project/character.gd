extends GridContainer

@onready var slots = get_children()

func equip(item):
	var player = get_tree().current_scene.find_child("Player", true, false)
	if player:
		player.current_item = item
	else:
		print("Player not found to equip item.")

func clear_character():
	for slot in slots:
		slot.item = null

func reapply_equipped_item():
	for slot in slots:
		if slot.item != null:
			equip(slot.item)
			break
