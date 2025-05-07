extends Node


var state_quest: String = ""

var func_call:
	set(value):
		func_call = value
		match value:
			"change_to_background":
				get_tree().change_scene_to_file("res://background.tscn")
			"change_to_quest1":
				get_tree().change_scene_to_file("res://Quests/quest_1.tscn")
			"give_sword_and_change":
				give_sword_and_change()
			_:
				print("Unknown func_call:", value)

var pending_item: Resource = null

var give_sword:
	set(value):
		pending_item = value  # Delay actual giving

func _process(_delta):
	try_give_pending_item()

func try_give_pending_item():
	if pending_item and Inventory:
		print("Checking inventory readiness...")
		if Inventory.has_space():
			print("Inventory has space. Giving:", pending_item)
			Inventory.add_item(pending_item)
			pending_item = null
		else:
			print("Inventory reports no space.")
	else:
		print("Inventory is null or no pending item.")



func give_sword_and_change():
	var item = load("res://Basic Sword.tres")
	pending_item = item
	# Switch scene first
	get_tree().change_scene_to_file("res://background.tscn")
