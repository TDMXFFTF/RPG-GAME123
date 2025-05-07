extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in Inventory.get_children():
		slot.item = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
