extends PlatformComponent

@export var finish: Node3D
@export var message: Label
@export var enabled := true
@export var step_node: Node3D

func _on_area_3d_body_entered(body):
	if body.is_in_group('player') and enabled:
		if is_instance_valid(finish): 
			finish.visible = true 
			if finish.get('enabled') != null: 
				finish.enabled = true
			elif finish.has_node('FinishPlatformComponent'):
				finish.get_node('FinishPlatformComponent').enabled = true
		
		if is_instance_valid(step_node): step_node.visible = false
		
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

func _on_object_entered(obj):
	_on_area_3d_body_entered(obj)
