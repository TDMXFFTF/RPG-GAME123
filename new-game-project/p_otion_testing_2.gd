extends AnimatedSprite2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		IdontKnowingly.potions += 1
		queue_free()
#i have no idea why its "IdontKnowingly"
