extends AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	connect ("animation_finished",self,"on_AnimatedSprite_animation_finished")

	
func on_AnimatedSprite_animation_finished():
	if self.animation == "Walk":
		animation = "jump"
	else:
		animation = "Walk"
			
	
