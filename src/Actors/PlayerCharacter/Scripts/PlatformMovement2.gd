extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 24
const ACCELERATION = 32
const MAXSPEED = 256
const JUMP_POWER = -512
const PROJECTILE = preload("res://src/Actors/PlayerCharacter/Nodes/Projectile.tscn")
var isClimbing = false
var canClimb = false
var canJump = false
var canRope = false
var hLadder = false
var onLedge = false
var movement = Vector2()
var friction = false	
export var modGravity = 0.0
var groundFriction = 0.15
var airResistance = 0.10
var ladderFriction = 0.5
var state_machine

var input_axis
var inputAction

onready var mySprite = $Sprite	
onready var combo_system = $ComboControl
onready var input_commands = $InputCommands
onready var ledge_ray_up = $LedgeRays/LedgeRayUp
onready var ledge_ray_down = $LedgeRays/LedgeRayDown

func _ready() -> void:
	state_machine = $AnimationTree.get("parameters/playback")
	modGravity = GRAVITY

func _physics_process(delta):	
	movement.y += modGravity
	
	if is_on_floor():
		canJump = true
		movement.x = lerp(movement.x,0,groundFriction)
		
	else:
		if not isClimbing or not onLedge:
			movement.x = lerp(movement.x,0,airResistance)
			modGravity = GRAVITY
			canJump = false	
	
	move()
	readActionButtons()
	
	
	movement = move_and_slide(movement, UP,false)
	
func readAxis():
	input_axis = input_commands.call("readAxisInputs")
	pass

func readActionButtons():
	inputAction = input_commands.call("readActionButtons")	
	shoot()
	melee()
	combo_system.combo_process()	
	
	if canJump:
		jump()	
	pass

func move():
	readAxis()
	var currentState= state_machine.get_current_node()		
	if input_axis.x > 0:
		#movement.x += input_axis.x * ACCELERATION
		movement.x = min(movement.x + (input_axis.x * ACCELERATION), MAXSPEED)
		mySprite.flip_h = false		
		if sign($WeaponControl.scale.x) == -1:
			$WeaponControl.scale.x *=-1
			$LedgeRays.scale.x *=-1
	
	if input_axis.x < 0:
		#movement.x += input_axis.x * ACCELERATION
		movement.x = max(movement.x + (input_axis.x * ACCELERATION), -MAXSPEED)
		mySprite.flip_h = true	
		if sign($WeaponControl.scale.x) == 1:
			$WeaponControl.scale.x *= -1
			$LedgeRays.scale.x *=-1
	
	if input_axis.abs().x > 0.1 and is_on_floor():
		runAnim()	
	
	if input_axis.abs().x < 0.1 and is_on_floor():
		state_machine.travel("Idle")
	
	if movement.y > 50 and not isClimbing:
		state_machine.travel("Fall")		
		
	if canClimb:	
		ladder(input_axis)
		
	if canRope:
		rope(input_axis)
	
	ledgeGrab()	
	
	
		
func ladder(inputs):
	
	if inputs.y > 0:
		isClimbing = true
		movement.y += inputs.y * ACCELERATION		
		
	if inputs.y < 0:
		isClimbing = true
		movement.y += inputs.y * ACCELERATION	
	
	if isClimbing:		
		modGravity = 0
		movement.x = lerp(movement.normalized().x,0,1)
		movement.y = lerp(movement.y,0,groundFriction)
		canJump = true
		state_machine.travel("Idle")	
	
	pass

func rope(inputs):
	
	if inputs.y > 0:
		hLadder = true	
		
	if inputs.y < 0:
		hLadder = true	
	
	if hLadder:
		modGravity = 0
		movement.y = 0
		movement.x = lerp(movement.x,0,airResistance)
		canJump = true
		state_machine.travel("Idle")
	pass
	
func jump():
	if input_commands.readActionButtons() == "Jump":
		movement.y = JUMP_POWER	
		state_machine.travel(input_commands.readActionButtons())
		if isClimbing:
			isClimbing = false	
		
		if hLadder:
			hLadder = false		
		
		if onLedge:
			onLedge = false
	pass
	
func ledgeGrab():
	onLedge = (ledge_ray_down.is_colliding() and ledge_ray_up.is_colliding() == false)
	
	if onLedge and Input.is_action_pressed("Use"):
		modGravity = 0
		movement.x = lerp(movement.normalized().x,0,1)
		movement.y = lerp(movement.normalized().y,0,1)
		canJump = true
		state_machine.travel("Idle")
func runAnim():
	state_machine.travel("Run")
	
func shoot():
	if input_commands.readActionButtons() == "Shoot":
		state_machine.start(input_commands.readActionButtons())
	pass
	
func melee():
	if input_commands.readActionButtons() == "Melee":
		state_machine.start(input_commands.readActionButtons())
	
func projectile():
	var projectile = PROJECTILE.instance()
	if sign($WeaponControl.scale.x) == 1:
		projectile.set_projectile_direction(1)
	else:
		projectile.set_projectile_direction(-1)
		
	get_parent().add_child(projectile)
	projectile.position = $WeaponControl/RangedWeaponPoint.global_position	
	pass
	

