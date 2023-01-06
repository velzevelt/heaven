class_name MovingPlatform extends Node3D

signal move_started

@export var autoplay := true
@export var loop := true

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var path = $Path3D as Path3D

func _ready():
	if autoplay:
		move_platform()


func move_platform():
	anim_player.play('move_platform')
	move_started.emit()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'move_platform' and loop:
		move_platform()
