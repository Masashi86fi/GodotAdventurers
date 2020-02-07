extends Node

var hitArray = []
var sampleComboArray = ["Melee","Melee","Melee"]
var otherComboTest = ["Shoot", "Melee", "Melee"]
const COMBOTIME_DEFAULT = 0.5
var comboTimer = 0.5
var isComboStarted = false

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
	if hitArray == sampleComboArray and isComboStarted:
		print("3 melee combo")
		isComboStarted = false
	
	if hitArray == otherComboTest and isComboStarted:
		print("2 melee 1 shoot combo")
		isComboStarted = false		
	pass
	
func testDictionary():
	# This is just for testing dictionary in general, code is from Godot website
	# Later switch to having all the known combos as Keys and combo Names 
	# as values. Names will be used to call the animation names when that
	# functionality is implemented.
	var d = {4: 5, "A key": "A value", 28: [1, 2, 3]}
	d["Hi!"] = 0
	d = {
	22: "value",
	"some_key": 2,
	"other_key": [2, 3, 4],
	"more_key": "Hello"
	}	
	pass
