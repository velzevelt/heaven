class_name Platform extends Node3D

signal player_entered
signal player_exited

@onready var area = $Area3D

func _ready():
	area.body_entered.connect(_on_area_3d_body_entered)
	area.body_exited.connect(_on_area_3d_body_exited)

func _on_area_3d_body_entered(body):
	if body is Player:
		player_entered.emit()
		_on_player_entered()


func _on_area_3d_body_exited(body):
	if body is Player:
		player_exited.emit()
		_on_player_exited()


func _on_player_entered():
	pass

func _on_player_exited():
	pass

