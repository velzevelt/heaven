extends MeshInstance3D

@export var video_material: BaseMaterial3D
@onready var video_player: VideoStreamPlayer = $SubViewport/VideoStreamPlayer


func _process(_delta):
	if visible:
		var texture = video_player.get_video_texture()
		video_material.albedo_texture = texture
#		texture.get_image().save_png('res://tmp/video_frame.png')
#		breakpoint

func _on_video_stream_player_finished():
	video_player.play()

