extends Node2D

signal menu_closed

var dialogue_manager : DialogueManager
var quest1_done = false
var quest1_active = false
var test_quest = 0

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
			DialogueManager.show_example_dialogue_balloon(load("res://2nd.dialogue"),"start")

#func _unhandled_input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#var actionables = actionable_finder.get_overlapping_areas()
		#if actionables.size() > 0:
			#DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"),"start")
			#return
