extends KinematicBody2D
#speed 
var speed = 200

var target = Vector2()
var velocity = Vector2()


func _input(event):
	#input_map L.click is leftclick
	if event.is_action_pressed('L_click'):
		#using rotation to rotate sprite to mouse position
		rotation = get_global_mouse_position().angle_to_point(position)
		target = get_global_mouse_position()
		
func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	#can cause jitternes if less than 5
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
