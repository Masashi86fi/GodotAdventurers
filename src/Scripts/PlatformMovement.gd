extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 24
const ACCELERATION = 32
const MAXSPEED = 256
const JUMP_POWER = -512

var movement = Vector2()

func _physics_process(delta):
	
	var mySprite = $Sprite
	var friction = false
	var groundFriction = 0.35
	var airResistance = 0.05	
	
	if Input.is_action_pressed("WalkR"):		
		movement.x = min(movement.x + ACCELERATION, MAXSPEED)
		mySprite.flip_h = false		
		#print("Walk anim R")
	elif Input.is_action_pressed("WalkL"):		
		movement.x = max(movement.x - ACCELERATION, -MAXSPEED)
		mySprite.flip_h = true
		#print("Walk anim L")
	else:
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			movement.y = JUMP_POWER	
			#print("Jump Anim")
		if friction == true:
			movement.x = lerp(movement.x,0,groundFriction)
	else:		
		movement.y += GRAVITY
		if friction == true:
			movement.x = lerp(movement.x,0,airResistance)
			
	move_and_slide(movement, UP)	

