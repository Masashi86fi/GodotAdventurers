extends Node
class_name InputCommands

enum ActionButtons {NONE, PUNCH, SHOOT, BLOCK, USE, JUMP}

func _process(delta: float) -> void:
	#print(readActionButtons())
	#print(readAxisInputs())
	
	pass
	
func readAxisInputs() -> Vector2:
	var axisRight = Input.get_action_strength("WalkR")
	var axisLeft = Input.get_action_strength("WalkL")	
	var axisUp = Input.get_action_strength("LadderUP")
	var axisDown = Input.get_action_strength("LadderDown")
	var axisValues = Vector2(axisRight - axisLeft,axisDown - axisUp)
	return axisValues
	
func readActionButtons() -> int:
	var buttonID = 0
	if Input.is_action_just_pressed("Shoot"):
		buttonID = ActionButtons.SHOOT
	elif Input.is_action_just_pressed("Melee"):
		buttonID = ActionButtons.PUNCH
	elif Input.is_action_just_pressed("Block"):
		buttonID = ActionButtons.BLOCK
	elif Input.is_action_just_pressed("Use"):
		buttonID = ActionButtons.USE
	elif Input.is_action_just_pressed("Jump"):
		buttonID = ActionButtons.JUMP
	else:
		buttonID = ActionButtons.NONE
	
	return buttonID
	
