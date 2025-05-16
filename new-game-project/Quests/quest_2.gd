extends Node2D
class_name Quest_2

var kil = 0

func mob_killed() -> void:
	kil += 1
	print("Kills: ", kil)
	if kil >= 10:
		State.state_quest = "done2"
		print("Quest complete!")
