extends AnimatedSprite

var speed = 1
var runsSpeed = 3
var jumpHeight = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):			
	if Input.is_key_pressed(KEY_LEFT):				
			self.position.x-= 1*delta			
	if Input.is_key_pressed(KEY_RIGHT):			
			self.position.x+= 1*delta
	if Input.is_action_just_pressed("Jump"):
		self.position.y -= jumpHeight *delta	
