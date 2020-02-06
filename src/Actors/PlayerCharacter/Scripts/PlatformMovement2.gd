extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 24
const ACCELERATION = 64
const MAXSPEED = 256
const JUMP_POWER = -512

var movement = Vector2()

onready var commands = $InputCommands

func _physics_process(delta):
	
	var mySprite = $Sprite
	var friction = false
	var groundFriction = 0.25
	var airResistance = 0.05	
	
	movement.x = movement.x + commands.call("readAxisInputs").x * ACCELERATION	
	mySprite.flip_h = false if movement.x > 0 else true
	if movement.x >= MAXSPEED:
		movement.x = MAXSPEED		
	elif movement.x <= -MAXSPEED:
		movement.x = -MAXSPEED		
	else:
		friction = true
		movement.x = lerp(movement.x,0,airResistance)
		
	if is_on_ceiling():
		friction = true
		
		movement.y = lerp(movement.x,0,1)
	if is_on_wall():		
		if Input.is_action_just_pressed("Jump"):
			movement.y = JUMP_POWER	
		movement.x = lerp(movement.x,0,groundFriction)	
	
	if is_on_floor():	
		friction = true	
		if Input.is_action_just_pressed("Jump"):
			movement.y = JUMP_POWER	
				#print("Jump Anim")
		if friction == true:
			movement.x = lerp(movement.x,0,groundFriction)
	else:		
		movement.y += GRAVITY		
		
	move_and_slide(movement, UP)
