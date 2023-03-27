extends Node3D

@export var finish: Node
@export var message: Label
@export var enabled := true

func _on_area_3d_body_entered(body):
	if body.is_in_group('player') and enabled:
		finish.visible = true
		finish.enabled = true
		visible = false
		enabled = false
		
		message.visible_ratio = 0.0
		message.visible = true
		var tween = get_tree().create_tween()
		tween.tween_property(message, 'visible_ratio', 1.0, 2.0)
		
		await tween.finished
		await get_tree().create_timer(2.0).timeout
		tween = get_tree().create_tween()
		tween.tween_property(message, 'visible_ratio', 0.0, 2.0)
		
		await tween.finished
		message.visible = false
