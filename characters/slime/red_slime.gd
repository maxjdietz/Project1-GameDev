extends CharacterBody2D

var health = 2
var slimeSpeed := 300


@onready var player = get_node("/root/Game/Player")

func _ready():
	%redSlime.play_walk()
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * slimeSpeed
	move_and_slide()


signal kill_for_xp

func increase_speed(speed):
	slimeSpeed = speed
	

func take_damage():
	health -= 1

	if health == 0:
		kill_for_xp.emit()
		queue_free()
		
	%redSlime.play_hurt()
	const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_SCENE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
