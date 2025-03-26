extends Node2D

signal menu_closed

var dialogue_manager : DialogueManager
var quest1_done = false
var quest1_active = false
var test_quest = 0

func on_yes_choice():
	print("Yes clicked!") 
	quest1_active = true
	
	
func on_no_choice():
	print("No clicked!") 
	test_quest += 1
	
func _process(delta: float) -> void:
	if quest1_active:
		if test_quest == 1:
			print("you did it!")
			quest1_active = false
			quest1_done = true
