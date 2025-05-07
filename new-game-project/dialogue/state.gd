extends Node


var state_quest: String = ""
var inventory = null

var func_call:
	set(value):
		func_call = value
		if inventory:
			inventory.func_call = value
		else:
			print("Inventory not set.")
