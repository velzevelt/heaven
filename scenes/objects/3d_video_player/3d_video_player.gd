extends MeshInstance3D

@onready var video_material: BaseMaterial3D = get_active_material(0)
@onready var video_player: VideoStreamPlayer = $SubViewport/VideoStreamPlayer
@onready var timer: Timer = $Timer

func _ready():
	update_texture()
	timer.timeout.connect(update_texture)
	timer.start(video_player.buffering_msec / 1000.0)


func update_texture():
	if visible:
		var texture = video_player.get_video_texture()
		video_material.albedo_texture = texture


func _on_video_stream_player_finished():
	video_player.play()

