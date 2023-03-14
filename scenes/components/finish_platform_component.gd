@tool
class_name FinishPlatformComponent
extends PlatformComponent

signal finished

var body: CharacterBody3D

func _on_object_entered(body: CharacterBody3D):
	if self.body == null:
		self.body = body

func _on_object_exited(body):
	if self.body == body:
		self.body = null

func _physics_process(delta):
	if not Engine.is_editor_hint() and is_instance_valid(self.body):
		# Player can fall from this platform due to inertia, we must be sure he stands still
		if body.velocity == Vector3.ZERO:
			# Player can slide out from finish platform to another body, so has to recheck it
			var last_collision = body.get_last_slide_collision()
			if is_instance_valid(last_collision):
				if last_collision.get_collider() == platform_body:
					self.body = null # Break physics loop to register player_finished only once
					await get_tree().create_timer(0.4).timeout # Little delay before finish registration
					finished.emit()
					Events.player_finished.emit()
					Logger.debug_log("Player finished level!")
					
					# Has to delete self after finish registration to avoid collision conflicts
					# Conflict happens when 2 or more colliders too close to each other
					self.queue_free()
