extends Node

var hitArray = []

const COMBOTIME_DEFAULT = 0.5
var comboTimer = 0.5
var isComboStarted = false
onready var anim = get_parent().get_node("AnimationTree").get("parameters/playback")
var actionKeys = ["Melee","Shoot","WalkL","WalkR"]
	
var combo_dict = {
	["Melee","Melee","Melee"]: "Triple Strike", 
	["Shoot", "Melee", "Melee"]: "Shoot And Strike", 
	["Shoot", "Shoot", "Shoot"]: "Burst"}

func combo_process():
	if comboTimer <= 0:
		hitArray.clear()
		comboTimer = COMBOTIME_DEFAULT
		isComboStarted = false
		return	
	
	if Input.is_action_just_pressed(actionKeys[0]):
		comboInputs(actionKeys[0])
		print(hitArray)
		
	if Input.is_action_just_pressed(actionKeys[1]):
		comboInputs(actionKeys[1])
		print(hitArray)
		
	comboTimer -= 1* get_physics_process_delta_time()
		
	checkCombo()	
	pass
	
func comboInputs(var hitType):
	var newSize = hitArray.size()
	hitArray.resize(newSize)
	hitArray.push_front(hitType)
	isComboStarted = true
	pass

func checkCombo():	
	if combo_dict.has(hitArray) and isComboStarted:	
		print(combo_dict.get(hitArray))	
		anim.travel(combo_dict.get(hitArray))
		isComboStarted = false
			
