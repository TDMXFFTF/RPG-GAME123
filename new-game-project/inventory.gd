extends GridContainer

@onready var slots = get_children()

func _ready():
	print("Inventory ready. Checking slots...")
	for slot in slots:
		print("Slot:", slot.name, "item:", slot.item)

func add_item(item : Item):
	for slot in get_children():
		if slot.item == null:
			slot.item = item
			return
	print("Can't add any more item...")


func remove_item(item : Item):
	for slot in get_children():
		if slot.item == item:
			slot.item = null
			return
	print("Item not found...")


func has_space() -> bool:
	for slot in get_children():
		if slot.item == null:
			return true
	return false



func force_give_item(item: Item):
	print("Force adding item to first slot.")
	if slots.size() > 0:
		slots[0].item = item
