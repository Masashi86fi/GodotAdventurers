extends AnimatedSprite

func _physics_process(delta: float) -> void:						
		var inputs: = get_inputs()
		if inputs.x < -0.1:
			self.flip_h = true
			self.animation = "Walk"	
			self.playing = true
		else:
			self.playing = false
			
		if inputs.x > 0.1:
			self.flip_h = false
			self.animation = "Walk"		
			self.playing = true	
		else:
			self.playing = false
			
		if inputs.y <0.1:			
			self.animation = "Jump"
		else:
			self.playing = false
				
		
func get_inputs() -> Vector2:
	return Vector2(Input.get_action_strength("WalkR") - Input.get_action_strength("WalkL"), 
		-1.0 if Input.is_action_just_pressed("Jump")and Input.is_action_just_released("Jump") else 1.0)	
