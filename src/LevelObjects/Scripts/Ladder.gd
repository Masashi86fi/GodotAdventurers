extends Area2D

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":		
		get_node(body.get_path()).canClimb = true



func _on_Area2D_body_exited(body: Node) -> void:
	if body.name == "Player":
		get_node(body.get_path()).isClimbing = false
		get_node(body.get_path()).canClimb = false
