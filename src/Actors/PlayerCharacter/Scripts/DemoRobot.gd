extends KinematicBody2D

export var speed: = Vector2(300,600)

var velocity: = Vector2.ZERO

var accelerate = 1.5
export var gravity: = 900.0
var minimumJumpHeight = 100

func _physics_process(delta: float) -> void:				
		var direction: = get_direction() 				
		var is_jump_interrupted: = Input.is_action_just_released("Jump") and velocity.y < 0.0
		velocity = calculate_move_velocity(velocity,direction,speed,is_jump_interrupted)
		velocity = move_and_slide(velocity,Vector2.UP)

func get_direction() -> Vector2:
	return Vector2(Input.get_action_strength("WalkR") - Input.get_action_strength("WalkL"),
		-1.0 if Input.is_action_just_pressed("Jump")and is_on_floor() else 1.0)	
		
func calculate_move_velocity(
	linear_velocity: Vector2, 
	direction: Vector2, 
	_speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = _speed.x * direction.x
	new_velocity.y += (gravity*accelerate) * get_physics_process_delta_time()	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y				
	if is_jump_interrupted:
		new_velocity.y = minimumJumpHeight
	return new_velocity
	
	
