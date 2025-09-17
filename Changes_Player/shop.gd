extends Control


@onready var upgrade_1: Button = $VBoxContainer/Upgrade1
@onready var upgrade_2: Button = $VBoxContainer/Upgrade2
@onready var upgrade_3: Button = $VBoxContainer/Upgrade3
signal upgrade_pressed(numOfUpgrade: int)



func _on_upgrade_1_pressed() -> void:
	
	upgrade_pressed.emit(1)


func _on_upgrade_2_pressed() -> void:
	upgrade_pressed.emit(2)


func _on_upgrade_3_pressed() -> void:
	upgrade_pressed.emit(3)
