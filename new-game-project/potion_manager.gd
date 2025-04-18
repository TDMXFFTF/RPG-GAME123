extends Node

var potions = 0

func _process(delta: float) -> void:
	$"GUI/PotionValue".text = str(potions)
