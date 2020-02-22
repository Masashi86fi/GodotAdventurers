extends Node
class_name InputCommands

#enum ActionButtons {NONE, PUNCH, SHOOT, BLOCK, USE, JUMP}
	
func readAxisInputs() -> Vector2:
	var axisRight = Input.get_action_strength("WalkR")
	var axisLeft = Input.get_action_strength("WalkL")	
	var axisUp = Input.get_action_strength("LadderUP")
	var axisDown = Input.get_action_strength("LadderDown")
	var axisValues = Vector2(axisRight - axisLeft,axisDown - axisUp)
	return axisValues
	
func readActionButtons() -> String:
	var buttonID = ""
	if Input.is_action_just_pressed("Shoot"):
		buttonID = "Shoot"
	elif Input.is_action_just_pressed("Melee"):
		buttonID = "Melee"
	elif Input.is_action_just_pressed("Block"):
		buttonID = "Block"
	elif Input.is_action_just_pressed("Use"):
		buttonID = "Use"
	elif Input.is_action_just_pressed("Jump"):
		buttonID = "Jump"
	elif Input.is_action_just_pressed("Shoot"):
		buttonID = "Shoot"
	else:
		buttonID = ""
	
	#print(buttonID)
	return buttonID
	
