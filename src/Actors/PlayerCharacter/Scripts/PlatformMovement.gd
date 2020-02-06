extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 24
const ACCELERATION = 32
const MAXSPEED = 256
const JUMP_POWER = -512
var isClimbing = false
var canClimb = false
var movement = Vector2()
var friction = false	
var modGravity = 0.0
var groundFriction = 0.15
var airResistance = 0.05
var ladderFriction = 0.5

onready var mySprite = $Sprite	

func _physics_process(delta):
	modGravity = GRAVITY
	move()
	
	if is_on_floor():
		movement.x = lerp(movement.x,0,groundFriction)	
		jump()			
	else:
		if isClimbing == true:
			modGravity = 0
			movement.y = lerp(movement.y,0,groundFriction)	
			movement.x = lerp(movement.x,0,groundFriction)	
			move()
			jump()
		else:
			movement.y += modGravity	
	#print(isClimbing)
	move_and_slide(movement, UP,false)
	
func move():	
	if Input.is_action_pressed("WalkR"):
		movement.x = min(movement.x + ACCELERATION, MAXSPEED)
		mySprite.flip_h = false	
		# Switch animation here for walking or call animation system to run
	elif Input.is_action_pressed("WalkL"):
		movement.x = max(movement.x - ACCELERATION, -MAXSPEED)
		mySprite.flip_h = true
		#print("Walk anim L")
	elif Input.is_action_pressed("LadderUP") and canClimb:
		isClimbing = true		
		movement.y = max(movement.y - ACCELERATION, -MAXSPEED)
	elif Input.is_action_pressed("LadderDown") and canClimb:
		isClimbing = true
		movement.y = min(movement.y + ACCELERATION, MAXSPEED)

func jump():
	if Input.is_action_just_pressed("Jump"):
		movement.y = JUMP_POWER	
		#print("Jump Anim")
		if isClimbing:
			isClimbing = false
	pass


