extends Node2D

var slimeSpeed = 300
var levelChecker = 1



func _ready():
	
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	

	
	
	
	
func spawn_king():
	var king_mob = preload("res://Changes_Player/slimeKING.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	king_mob.global_position = %PathFollow2D.global_position
	add_child(king_mob)
	king_mob.kill_for_xp.connect(_on_slime_death)

func spawn_mob():
	var new_mob = preload("res://Changes_Player/SlimeGuy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	
	add_child(new_mob)
	new_mob.increase_speed(slimeSpeed)
	new_mob.kill_for_xp.connect(_on_slime_death)
	#if (levelUpReady == 1):
		#new_mob.increase_speed()
		
		#levelUpReady = 0
	
	


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true
	
	
	
func _on_slime_death():
	%LevelUpbar.value += 10


func _on_level_upbar_level_up() -> void:
	slimeSpeed += 100
	levelChecker += 1
	spawn_king()
