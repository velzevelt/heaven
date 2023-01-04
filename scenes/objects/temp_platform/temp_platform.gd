extends MovingPlatform

@export var live_time := 10.0
@export var autofall := false
@export var touch_respond := true
@onready var timer = $Timer as Timer # BE SURE THAT ONESHOT IS ENABLED
@onready var base_platform = $Platform as AnimatableBody3D
@onready var rigidbody = $FallingPlatform as RigidBody3D

func _ready():
	if autofall:
		_on_player_entered()


func _on_player_entered():
	timer.start(live_time)


func _on_area_3d_body_entered(body):
	if body is Player and touch_respond:
		_on_player_entered()


func _on_timer_timeout():
	# Turn off Base platform and enable Rigidbody with gravity, delete all after delay
	call_deferred('free')
