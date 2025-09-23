extends Node2D

signal coinGot


func _ready():
	play_spin( )


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("COIN")
		coinGot.emit(2)
		queue_free()
		
func play_spin():
	%AnimationPlayer.play("Coin Spin")
