extends ProgressBar
@onready var level_upbar: ProgressBar = $"."

var levelNum = 1
signal levelUp
#@onready var level_upbar: ProgressBar = $"."
#@onready var root_node = get_tree().root



func _process(delta):
	if (level_upbar.value == 100):
		level_upbar.value = 0
		levelUp.emit()
		levelNum += 1
		%Label.text = "Level " + str(levelNum)
		
	
	
	
	
	
func _ready():
	%Label.text = "Level " + str(levelNum)
	
	
