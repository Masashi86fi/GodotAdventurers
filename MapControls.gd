extends KinematicBody2D
#speed 
var speed = 200
var can_trigger = false

var target = Vector2()
var velocity = Vector2()


func _input(event):
	#input_map L_click is leftclick
	if event.is_action_pressed('L_click'):
		#using rotation to rotate sprite to mouse position
		#only rotate sprite
		$Sprite.rotation = get_global_mouse_position().angle_to_point(position)
		target = get_global_mouse_position()


func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	#can cause jitternes if less than 5
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
		#ubdate_line
		ubdate_line()

func ubdate_line():
	#remove last line make new line
	removeLine()
	createLine($Line2D.position, target - position)

func createLine(from, to):
  $Line2D.add_point(from)
  $Line2D.add_point(to)

func removeLine():
  $Line2D.points = []

#signal if howering on planet etc
func _on_Trigger_area_entered(area):
	#removeline
	removeLine()
	#can trigger
	can_trigger = true
	print("i Can trigger")
	#variable id from planet(area2d) script
	print (area.Id)
	#use area._return_something() function
	print(area._return_something())
	#name of area 
	print (area.name)
	#chekking groups
	if area.is_in_group("planets"):
		print ("iam in group planets")
	else:
		print("i am not in group planets")

#signal whehen not howering planet etc
func _on_Trigger_area_exited(area):
	#cant trigger
	can_trigger = false
	print("i cannot trigger")
