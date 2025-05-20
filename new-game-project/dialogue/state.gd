extends Node

var state_quest: String = ""
var inventory = null

func _ready():
	inventory = get_node("/root/Inventory")

var func_call:
	set(value):
		match value:
			"give_sword1":
				if state_quest == "finished1" and inventory:
					inventory.add_item(load("res://Basic Sword.tres"))
				else:
					print("Quest not completed yet.")
			"give_sword2":
				if state_quest == "completed!" and inventory:
					inventory.add_item(load("res://Second Sword.tres"))
				else:
					print("Quest not completed yet.")
			"give_sword3":
				if state_quest == "completed!2" and inventory:
					inventory.add_item(load("res://Final Sword.tres"))
				else:
					print("Quest not completed yet.")
			"change_to_background":
				change_scene_with_loading("res://background.tscn")
			"change_to_quest1":
				change_scene_with_loading("res://Quests/quest_1.tscn")
			"change_to_quest2":
				change_scene_with_loading("res://Quests/quest_2.tscn")
			"change_to_quest3":
				change_scene_with_loading("res://quest_3.tscn")
			"change_to_quest4":
				change_scene_with_loading("res://quest_4.tscn")
			"change_to_boss":
				change_scene_with_loading("res://final_boss_map.tscn")
			"change_to_cutscene":
				change_scene_with_loading("res://cutscene.tcsn")
			_:
				print("Unknown func_call:", value)

func change_scene_with_loading(scene_path: String):
	var loading_scene = load("res://loading_screen.tscn").instantiate()
	loading_scene.next_scene_path = scene_path
	get_tree().root.add_child(loading_scene)
