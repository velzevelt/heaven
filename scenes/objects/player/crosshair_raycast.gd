extends RayCast3D

signal target_spotted
signal target_losted

var _spotted:
	set(value):
		_spotted = value
		if _spotted:
			target_spotted.emit()
		else:
			target_losted.emit()

func _physics_process(_delta):
	if is_colliding() and not _spotted:
		self._spotted = true
	if not is_colliding() and _spotted:
		self._spotted = false
