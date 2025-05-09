extends GridContainer

@onready var slots = get_children()
signal inventory_ready

func toggle_visibility():
	get_tree().get_root().get_node("InventoryUI").visible = !visible

func _ready():
	State.inventory = self
	emit_signal("inventory_ready")

func add_item(item: Item):
	if item.resource_path != "":
		if item.resource_path not in Global.inventory_items:
			Global.inventory_items.append(item.resource_path)
	else:
		print("Item is not a saved resource")
	
	# Don't add if already in a slot
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
	clear_inventory()
	for path in Global.inventory_items:
		var item = load(path)
		if item:
			add_item(item)
		else:
			print("Failed to load item from:", path)
