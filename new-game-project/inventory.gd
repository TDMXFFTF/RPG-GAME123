extends GridContainer

@onready var slots = get_children()

func _ready():
	add_item(load("res://Basic Sword.tres"))
	add_item(load("res://Second Sword.tres"))
	add_item(load("res://Final Sword.tres"))

func add_item(item : Item):
	for slot in slots:
		if slot.item == null:
			slot.item = item
			return
	print("Can't add any more item...")

func remove_item(item : Item):
	for slot in slots:
		if slot.item == null:
			slot.item = item
			return
	print("Item not found...")
