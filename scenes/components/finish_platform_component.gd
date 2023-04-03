@tool
class_name FinishPlatformComponent
extends PlatformComponent

signal finished

@export var enabled := true

var body: CharacterBody3D


@warning_ignore("shadowed_variable")
func _on_object_entered(body: CharacterBody3D):
	if self.body == null:
		self.body = body

@warning_ignore("shadowed_variable")
func _on_object_exited(body):
	if self.body == body:
		self.body = null

func _physics_process(_delta):
	if not Engine.is_editor_hint() and is_instance_valid(self.body) and enabled:
		# Player can fall from this platform due to inertia, we must be sure he stands still
		if body.velocity == Vector3.ZERO:
			# Player can slide out from finish platform to another body, so has to recheck it
			var colliders = []
			for i in range(0, body.get_slide_collision_count()):
				colliders.append(body.get_slide_collision(i).get_collider())
			
			print(colliders)
			
			if platform_body in colliders:
				self.enabled = false # Has to disable self to register finish only once
				await get_tree().create_timer(0.4).timeout # Little delay before finish registration
				finished.emit()
				Events.player_finished.emit()
				
