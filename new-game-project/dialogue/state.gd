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
					"change_to_background"
					inventory.add_item(load("res://Basic Sword.tres"))
				else:
					print("Quest not completed yet.")
			"change_to_background":
				change_scene_with_loading("res://background.tscn")
			"change_to_quest1":
				change_scene_with_loading("res://Quests/quest_1.tscn")
			"change_to_quest2":
				change_scene_with_loading("res://Quests/quest_2.tscn")
			_:
				print("Unknown func_call:", value)

func change_scene_with_loading(scene_path: String):
	var loading_scene = load("res://loading_screen.tscn").instantiate()
	loading_scene.next_scene_path = scene_path
	get_tree().root.add_child(loading_scene)
