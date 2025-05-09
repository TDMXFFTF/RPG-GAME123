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
					await "change_to_background"
					inventory.add_item(load("res://Basic Sword.tres"))
				else:
					print("Quest not completed yet.")
			"change_to_background":
				get_tree().change_scene_to_file("res://Background.tscn")
			"change_to_quest1":
				get_tree().change_scene_to_file("res://Quests/quest_1.tscn")
			"change_to_quest2":
				get_tree().change_scene_to_file("res://Quests/quest_2.tscn")
			_:
				print("Unknown func_call:", value)
