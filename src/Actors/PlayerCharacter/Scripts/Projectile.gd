extends KinematicBody2D

var movement = Vector2()
var direction = 1
export var speed = 500

func set_projectile_direction(dir):
	direction = dir
	if direction == -1:
		$Sprite.flip_h = true
	pass

func _physics_process(delta: float) -> void:
	movement.x = speed * delta * direction
	var collision = move_and_collide(movement)
	if collision:
		queue_free()
	pass
	


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
