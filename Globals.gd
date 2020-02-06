extends Node

#Global like variables goes in here and can be accessed using Globals.variable name like Globals.tile_size
#if not working should chek Project-->Project settings-->AutoLoad name:Globals path:is where Globals script is 
#when ready we call scene_1 wich is first level

#scene_1 = Level.tscn in root 
onready var scene_1 = preload("res://Level.tscn")
#in here we can store variables
onready var tile_size = 32
