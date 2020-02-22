extends Node

var hitArray = []

const COMBOTIME_DEFAULT = 0.5
var comboTimer = 0.5
var isComboStarted = false
onready var anim = get_parent().get_node("AnimationTree").get("parameters/playback")
onready var input_commands = get_parent().get_node("InputCommands")
onready var tree_root = get_parent().get_node("AnimationTree").get("tree_root")	

var combo_dict = {
	["Melee","Melee","Melee"]: "Triple Strike", 
	["Shoot", "Melee", "Melee"]: "Shoot And Strike", 
	["Shoot", "Shoot", "Shoot"]: "Burst"}

func combo_process():
	var actionKey = input_commands.call("readActionButtons")
	if comboTimer <= 0:
		hitArray.clear()
		comboTimer = COMBOTIME_DEFAULT
		isComboStarted = false
		return	
	
	if actionKey!= "":	
		comboInputs(actionKey)			
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
		if tree_root.has_node(combo_dict.get(hitArray)):
			anim.travel(combo_dict.get(hitArray))
			print(combo_dict.get(hitArray))	
		isComboStarted = false
			
