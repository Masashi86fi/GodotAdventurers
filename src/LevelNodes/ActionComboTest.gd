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
		var newSize = hitArray.size()
		hitArray.resize(newSize)
		hitArray.push_front("Melee")
		isComboStarted = true
		print(hitArray)
		
	if Input.is_action_just_pressed("Shoot"):
		var newSize = hitArray.size()
		hitArray.resize(newSize)
		hitArray.push_front("Shoot")
		isComboStarted = true
		print(hitArray)
	
	if isComboStarted == true:
		comboTimer -= 1* delta
		
	if hitArray == sampleComboArray:
		print("3 melee combo")
		isComboStarted = false
		comboTimer = 0
	
	if hitArray == otherComboTest:
		print("2 melee 1 shoot combo")
		isComboStarted = false
		comboTimer = 0
	
	pass
