extends Area2D

onready var Id = "planeetta"

func _ready():
	add_to_group("planets")

func _return_something():
	return "something"
