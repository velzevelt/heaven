extends Node3D

@onready var anim_player = $AnimationPlayer as AnimationPlayer

func _ready():
	anim_player.play('move_platform')
