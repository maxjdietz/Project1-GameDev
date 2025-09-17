extends Area2D

var bulletSize = 1



func _physics_process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 0 # Adds a 90-degree offset
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
	if Input.is_action_just_pressed("shoot"):
		print("TEST")
		if (%Timer.time_left > 0):
			print("RELOADING!")
			
		else:
			print("SHOOT")
			shoot()
		
		

func shoot():
	
	const BULLET = preload("res://Changes_Player/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.scale = Vector2(bulletSize, bulletSize)
	
	
	%ShootingPoint.add_child(new_bullet)
	%Timer.start()


func _on_timer_timeout() -> void:
	pass


func _on_player_upgrade_gun() -> void:
	var timer_time = %Timer.wait_time
	%Timer.wait_time = timer_time/2
	
		
		


func _on_player_upgrade_bullet(upgradeKind: int) -> void:
	print("YESS")
	bulletSize += 0.5
