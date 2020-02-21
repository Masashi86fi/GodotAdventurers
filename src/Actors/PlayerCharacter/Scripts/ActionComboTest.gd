extends Node

var hitArray = []
#var sampleComboArray = ["Melee","Melee","Melee"]
const COMBOTIME_DEFAULT = 0.5
var comboTimer = 0.5
var isComboStarted = false
	
var combo_dict = {
	["Melee","Melee","Melee"]: "Triple Strike", 
	["Shoot", "Melee", "Melee"]:"Shoot And Strike", 
	["Shoot", "Shoot", "Shoot"]:"Burst"}

func _process(delta: float) -> void:
	
	if comboTimer<=0:
		hitArray.clear()
		comboTimer = COMBOTIME_DEFAULT
		isComboStarted = false
	
	if Input.is_action_just_pressed("Melee"):
		comboInputs("Melee")
		print(hitArray)
		
	if Input.is_action_just_pressed("Shoot"):
		comboInputs("Shoot")
		print(hitArray)
		
	comboTimer -= 1* delta
		
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
		isComboStarted = false
		#print(points_dir.values())
	pass
	
func testDictionary():
	# This is just for testing dictionary in general, code is from Godot website
	# Later switch to having all the known combos as Keys and combo Names 
	# as values. Names will be used to call the animation names when that
	# functionality is implemented.
	pass
	
	
	
