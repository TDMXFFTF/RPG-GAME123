extends GridContainer

@onready var slots = get_children()

var dialogue_manager : DialogueManager

var func_call:
	set(value):
		match value:
			"give_sword_and_change":
				if State.state_quest == "finished1":
					add_item(load("res://Basic Sword.tres"))
				else:
					print("Quest not completed yet.")
			_:
				print("Unknown func_call:", value)

func _ready():
	State.inventory = self

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
