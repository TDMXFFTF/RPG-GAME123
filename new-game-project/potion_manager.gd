extends Node

var potions = 0

func _process(_delta: float) -> void:
	$"GUI/PotionValue".text = str(potions)
