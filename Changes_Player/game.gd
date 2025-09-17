extends Node2D

var slimeSpeed = 300
var levelChecker = 1
var currRound := 0
var money = 0

signal levelUpText

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout



func randNum(to, fro):

	var num = randf_range(to, fro)
	print(num)
	return num

func _ready():
	
	%Round.text = "Round: 1" 
	%Money.text = "0" 
	roundSystem(1)

	
	
func roundSystem(round):
	spawn_mob()
	for i in range(4):
		var randomNum = randNum(round, 15)
		if randomNum > 10:
			spawn_mob()
		if randomNum > 12:
			spawn_red()
		if randomNum > 14:
			spawn_king()
			
	
func setMoney(amount):
	money += amount
	if money < 0:
		money = 0
	%Money.text = "Money: " + str(money)
	
	
func enemyDie(position):
	print("ACTIVATED")
	const COIN_SCENE = preload("res://Changes_Player/coin.tscn")
	var coin = COIN_SCENE.instantiate()
	
	get_parent().add_child(coin)
	coin.coinGot.connect(setMoney)
	coin.global_position = position
	
func spawn_red():
	var red_guy = preload("res://Changes_Player/redSlime_Enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	red_guy.global_position = %PathFollow2D.global_position
	add_child(red_guy)
	red_guy.kill_for_xp.connect(_on_slime_death)
	red_guy.coinSpawn.connect(enemyDie)
	
	
	
func spawn_king():
	var king_mob = preload("res://Changes_Player/slimeKING.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	king_mob.global_position = %PathFollow2D.global_position
	add_child(king_mob)
	king_mob.kill_for_xp.connect(_on_slime_death)
	king_mob.coinSpawn.connect(enemyDie)
	

func spawn_mob():
	var new_mob = preload("res://Changes_Player/SlimeGuy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	
	add_child(new_mob)
	new_mob.increase_speed(slimeSpeed)
	new_mob.kill_for_xp.connect(_on_slime_death)
	new_mob.coinSpawn.connect(enemyDie)
	
	
	#if (levelUpReady == 1):
		#new_mob.increase_speed()
		
		#levelUpReady = 0
	
	


func _on_timer_timeout() -> void:
	#spawn_mob()
	pass


func _on_player_health_depleted() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true
	
	
	
func _on_slime_death():
	%LevelUpbar.value += 10


func _on_level_upbar_level_up() -> void:
	slimeSpeed += 100
	levelChecker += 1
	levelUpText.emit()




signal nextRound

func _on_num_of_enemies_no_enemies() -> void:
	currRound += 1
	%Round.text = "Round: " + str(currRound)
	print("round" + str(currRound))
	%ProceedButton.visible = true
	%Shop.visible = true
	



func _on_button_pressed() -> void:
	nextRound.emit()
	roundSystem(currRound)
	%ProceedButton.visible = false
	%Shop.visible = false



signal goodUpgrade(upgrade: int)

func _on_ui_set_money(upgradeNum) -> void:
	if upgradeNum == 1:
		if money >= 5:
			setMoney(-5)
			goodUpgrade.emit(1)
	elif upgradeNum == 2:
		if money >= 10:
			setMoney(-10)
			goodUpgrade.emit(2)
	elif upgradeNum == 3:
		if money >= 15:
			setMoney(-15)
			goodUpgrade.emit(3)
		
	
	
	
