extends Label

@onready var potion_value: Label = $"."

func _process(delta: float) -> void:
	$".".text = str(IdontKnowingly.potions)
