extends Node2D
#main sis set to main
#screen size
var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()

func _ready():
	#path in Globals.gd script in AUTOLOAD!-->settings-->autoload
	var scene_instance = Globals.scene_1.instance()
	OS.set_window_title("Peli")
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	add_child(scene_instance)
	
