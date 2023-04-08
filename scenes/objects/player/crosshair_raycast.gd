extends RayCast3D

@onready var _old_crosshair = $%Crosshair

var _active_collider

func _physics_process(_delta):
	if is_colliding():
		var collider = get_collider()
		
		if collider != _active_collider:
			if collider.has_node("OverridePlayerCrosshair"):
				var new_crosshair = collider.get_node("OverridePlayerCrosshair")
				Events.player_target_spotted.emit(new_crosshair)
			elif collider.get_parent().has_node("OverridePlayerCrosshair"):
				var new_crosshair = collider.get_parent().get_node("OverridePlayerCrosshair")
				Events.player_target_spotted.emit(new_crosshair)
			else:
				_old_crosshair.style = _old_crosshair._init_style # Need reset style to default before apllying new style
				Events.player_target_spotted.emit(_old_crosshair)
		
		_active_collider = collider
	else:
		Events.player_target_losted.emit(_old_crosshair)
