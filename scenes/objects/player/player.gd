class_name Player 
extends CharacterBody3D


func _ready():
	DebugLayer.draw.add_vector(self, "velocity", 1, 4, Color(0,1,0, 0.5))
