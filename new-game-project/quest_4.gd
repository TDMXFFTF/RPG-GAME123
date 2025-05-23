extends Node2D
class_name Quest_4

var kill = 0

func mob_killed() -> void:
	kill += 1
	if kill >= 20:
		State.state_quest = "finished4"
		QuestUI.show_message("QUEST COMPLETE")
