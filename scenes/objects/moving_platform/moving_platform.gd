class_name MovingPlatform extends Node3D

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@export var autoplay := true
@export var loop := true


func _ready():
	if autoplay:
		anim_player.play('move_platform')
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'move_platform' and loop:
		anim_player.play('move_platform')
