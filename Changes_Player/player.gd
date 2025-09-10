extends CharacterBody2D

var health = 100.0
var DAMAGE_RATE = 20.0

signal health_depleted
signal upgradeGun
var speed := 600



func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", 
	"move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		print("TESTING")
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		%HappyBoo.play_ouch_animation()
		if health <= 0.0:
			print("TESTING")
			health_depleted.emit()
			


func _on_level_upbar_level_up() -> void:
	speed += 100
	upgradeGun.emit()
