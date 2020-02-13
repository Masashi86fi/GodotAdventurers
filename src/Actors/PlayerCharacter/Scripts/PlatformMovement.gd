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
var state_machine

onready var mySprite = $Sprite	

func _ready() -> void:
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	modGravity = GRAVITY
	
	if not isClimbing: 
		movement.y += modGravity
	
	move()
	
	if is_on_floor():
		movement.x = lerp(movement.x,0,groundFriction)	
		#state_machine.travel("Land")			
		jump()			
	else:
		if isClimbing == true:
			modGravity = 0
			movement.y = lerp(movement.y,0,groundFriction)	
			movement.x = lerp(movement.x,0,groundFriction)	
			move()
			jump()
		else:
			movement.x = lerp(movement.x,0,airResistance)	
		
	movement = move_and_slide(movement, UP,false)
	
func move():	
	var currentState= state_machine.get_current_node()
	if Input.is_action_pressed("WalkR"):
		movement.x = min(movement.x + ACCELERATION, MAXSPEED)
		mySprite.flip_h = false			
	elif Input.is_action_pressed("WalkL"):
		movement.x = max(movement.x - ACCELERATION, -MAXSPEED)
		mySprite.flip_h = true		
	elif Input.is_action_pressed("LadderUP") and canClimb:
		isClimbing = true		
		movement.y = max(movement.y - ACCELERATION, -MAXSPEED)
		state_machine.travel("Idle")
	elif Input.is_action_pressed("LadderDown") and canClimb:
		isClimbing = true
		movement.y = min(movement.y + ACCELERATION, MAXSPEED)
		state_machine.travel("Idle")
	else:
		movement.x = 0
		
	
	if movement.length() < 25:
		state_machine.travel("Idle")
	
	if movement.y > 50:
		state_machine.travel("Fall")
	
	if is_on_floor():
		if movement.x > 0.1 or movement.x < -0.1:
			runAnim()
		
	#print(movement)
	

func jump():
	if Input.is_action_just_pressed("Jump"):
		movement.y = JUMP_POWER	
		state_machine.travel("Jump")
		if isClimbing:
			isClimbing = false
	pass

func runAnim():
	state_machine.travel("Run")

