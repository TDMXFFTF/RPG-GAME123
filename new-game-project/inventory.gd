extends GridContainer

@onready var slots = get_children()
@onready var character = $"../Character"

func toggle_visibility():
	get_tree().get_root().get_node("InventoryUI").visible = !visible

func _ready():
	State.inventory = self

func add_item(item: Item):
	if item.resource_path == "":
		print("Item is not a saved resource")
		return
	if item.resource_path in Global.inventory_items:
		print("Item already in inventory:", item.resource_path)
		return
	Global.inventory_items.append(item.resource_path)
	for slot in slots:
		if slot.item == item:
			return
	for slot in slots:
		if slot.item == null:
			slot.item = item
			return
	print("Can't add any more item...")


func clear_inventory():
	for slot in slots:
		slot.item = null

func remove_item(item: Item):
	for slot in slots:
		if slot.item == item:
			slot.item = null
			Global.inventory_items.erase(item.resource_path)
			return
	print("Item not found...")

func load_inventory():
	for path in Global.inventory_items:
		var item = load(path)
		if item:
			add_item(item)
		else:
			print("Failed to load item from:", path)
