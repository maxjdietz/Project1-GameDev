extends Label

var numOfEnemy
signal noEnemies


func _process(delta):
	
	numOfEnemy = get_tree().get_nodes_in_group("Enemy").size()
	%NumOfEnemies.text = "Enemies Left: " + str(numOfEnemy)
	if (numOfEnemy == 0):
		noEnemies.emit()
		print("HMM")
		
		set_process(false)
		
	

func _on_game_next_round() -> void:
	
	await get_tree().create_timer(1).timeout
	%NumOfEnemies.text = "Enemies Left: " + str(numOfEnemy)
	set_process(true)
