extends Node2D

signal menu_closed


var dialogue_manager = "res://addons/dialogue_manager/"
var quest1_done = false
var quest1_active = false
var test_quest = 0
var main_quest = false
var main_quest_done = false 


func _ready() -> void:
	pass
	
func test():
	test_quest += 1
	
	
func on_yes_choice():
	print("Yes clicked!") 
	quest1_active = true
	
	
func on_no_choice():
	print("No clicked!") 
	
func _process(delta: float) -> void:
	if quest1_active == true:
		if Input.is_action_just_pressed("test"):
			test()
		if test_quest == 5:
			quest1_active = false
			quest1_done = true
			DialogueManager.show_dialogue_balloon(load("res://2nd.dialogue"),"start")


func quest_start():
	main_quest = true
	print("uh oh")


func finished_quest() -> void:
	State.state_quest = "done"
