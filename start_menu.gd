extends Control


@onready var start: Button = $Start





func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Changes_Player/game.tscn")
	
