extends StaticBody2D
class_name Quest_3

var kill = 0

func mob_killed() -> void:
	kill += 1
	if kill >= 15:
		State.state_quest = "finished3"
		print ("quest complete")
