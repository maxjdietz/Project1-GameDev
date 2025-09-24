extends CharacterBody2D

var health = 1
var slimeSpeed := 300
signal coinSpawn(position: Vector2)


@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()
	
	
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * slimeSpeed
	move_and_slide()


signal kill_for_xp

func increase_speed(speed):
	slimeSpeed = speed
	

func take_damage():
	AudioManager.slime_hurtw.play()
	AudioManager.slime_hurtw.pitch_scale = randf_range(0.8, 1.2)
	health -= 1

	if health == 0:
		
		kill_for_xp.emit()
		coinSpawn.emit(global_position)
		queue_free()
		
		
	%Slime.play_hurt()
	const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_SCENE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
	
	
#func coinRetrieved():
	#pass
