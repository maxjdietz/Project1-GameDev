extends Area2D


var travel_distance = 0
const SPEED = 1000
const RANGE = 1200
var size = 1
var pitchRange


	
func _ready():
	AudioManager.shoot_w.play()
	AudioManager.shoot_w.pitch_scale = randf_range(0.8, 1.2)
	
	
func _physics_process(delta):
	

	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travel_distance += SPEED * delta
	if travel_distance > +RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
		



	
