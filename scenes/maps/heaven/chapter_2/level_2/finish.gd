extends Area3D

@export var target_group = 'cube'

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.is_in_group(target_group):
		await get_tree().create_timer(0.4).timeout
		Events.player_finished.emit()
