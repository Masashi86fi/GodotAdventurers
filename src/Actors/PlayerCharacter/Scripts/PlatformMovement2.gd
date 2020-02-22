extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 24
const ACCELERATION = 32
const MAXSPEED = 256
const JUMP_POWER = -512
var isClimbing = false
var canClimb = false
var canJump = false
var movement = Vector2()
var friction = false	
var modGravity = 0.0
var groundFriction = 0.15
var airResistance = 0.10
var ladderFriction = 0.5
var state_machine

onready var mySprite = $Sprite	
onready var combo_system = $ComboControl
onready var input_commands = $InputCommands

func _ready() -> void:
	state_machine = $AnimationTree.get("parameters/playback")
	modGravity = GRAVITY

func _physics_process(delta):	
	movement.y += modGravity
	
	if is_on_floor():
		canJump = true
		movement.x = lerp(movement.x,0,groundFriction)
		
	else:
		if not isClimbing:
			movement.x = lerp(movement.x,0,airResistance)
			modGravity = GRAVITY
			canJump = false
	
	move()
	combo_system.combo_process()
	
	movement = move_and_slide(movement, UP,false)
	
func move():	
	var currentState= state_machine.get_current_node()
	var input_axis = input_commands.call("readAxisInputs")
			
	if input_axis.x > 0:
		#movement.x += input_axis.x * ACCELERATION
		movement.x = min(movement.x + (input_axis.x * ACCELERATION), MAXSPEED)
		mySprite.flip_h = false		
	
	if input_axis.x < 0:
		#movement.x += input_axis.x * ACCELERATION
		movement.x = max(movement.x + (input_axis.x * ACCELERATION), -MAXSPEED)
		mySprite.flip_h = true			
	
	if input_axis.abs().x > 0.1 and is_on_floor():
		runAnim()	
	
	if input_axis.abs().x < 0.1 and is_on_floor():
		state_machine.travel("Idle")
	
	if movement.y > 50 and not isClimbing:
		state_machine.travel("Fall")	
	
	if canJump:
		jump()	
		
	if canClimb:	
		climbing(input_axis)
		
func climbing(inputs):
	
	if inputs.y > 0:
		isClimbing = true
		movement.y += inputs.y * ACCELERATION		
		
	if inputs.y < 0:
		isClimbing = true
		movement.y += inputs.y * ACCELERATION	
	
	if isClimbing:		
		modGravity = 0
		movement.x = lerp(movement.x,0,groundFriction)
		movement.y = lerp(movement.y,0,groundFriction)
		canJump = true
		state_machine.travel("Idle")	
	pass
	
func jump():
	if Input.is_action_just_pressed("Jump"):
		movement.y = JUMP_POWER	
		state_machine.travel("Jump")
		if isClimbing:
			isClimbing = false		
	pass

func runAnim():
	state_machine.travel("Run")
