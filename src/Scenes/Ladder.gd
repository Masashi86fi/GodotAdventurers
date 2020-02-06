extends Area2D

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":		
		get_node("../Player").canClimb = true


func _on_Area2D_body_exited(body: Node) -> void:
	if body.name == "Player":
		get_node("../Player").isClimbing = false
		get_node("../Player").canClimb = false
