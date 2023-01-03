extends Node


func _on_player_entered():
	Logger.debug_log("Player finished level!")


func _on_area_3d_body_entered(body):
	if body is Player:
		_on_player_entered()


func _on_timer_timeout():
	#
	pass
