extends RayCast3D

@export var player: Player
@export var door_marker: Marker3D
@export var prop_marker: Marker3D
@onready var data: RayCastData = RayCastData.new(self, self.player, self.door_marker, self.prop_marker)


var interactable_object = null


func _physics_process(_delta):
	if is_colliding():
		var collider = get_collider()
		if not is_instance_valid(interactable_object):
			if collider.has_method('interact_begin'):
				interactable_object = collider
				interactable_object.interact_begin(data)
		else:
			if interactable_object.has_method('interact_process'):
				interactable_object.interact_process()
	else:
		if is_instance_valid(interactable_object):
			if interactable_object.has_method('interact_end'):
				interactable_object.interact_end()
				interactable_object = null
			else:
				Logger.debug_log('%s object have interact_begin method but do have interact_end method!' % interactable_object.name, MESSAGE_TYPE.ERROR)


class RayCastData:
	var from: RayCast3D
	var player: Player
	var door_marker: Marker3D
	var prop_marker: Marker3D
	
	@warning_ignore("shadowed_variable")
	func _init(from, player, door_marker, prop_marker):
		self.from = from
		self.player = player
		self.door_marker = door_marker
		self.prop_marker = prop_marker
