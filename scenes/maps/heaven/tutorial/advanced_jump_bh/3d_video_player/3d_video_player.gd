extends MeshInstance3D

@export var video_material: StandardMaterial3D
@onready var view_port: SubViewport = $SubViewport
@onready var video_player: VideoStreamPlayer = $SubViewport/VideoStreamPlayer

func _ready():
	video_player.anchors_preset = Control.PRESET_FULL_RECT
	view_port.size = get_tree().root.size
	get_tree().root.size_changed.connect(func(): view_port.size = get_tree().root.size)
	get_tree().root.size_changed.connect(func(): video_player.anchors_preset = Control.PRESET_FULL_RECT)
	

func _process(_delta):
	if visible:
		var texture = view_port.get_texture()
		video_material.albedo_texture = texture
		texture.get_image().save_png('res://tmp/video_frame.png')
		breakpoint

func _on_video_stream_player_finished():
	video_player.play()


func _on_visible_on_screen_notifier_3d_screen_entered():
	visible = true


func _on_visible_on_screen_notifier_3d_screen_exited():
	visible = false
