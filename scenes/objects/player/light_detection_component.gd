extends Node3D

@export var player: Player
@export var player_camera: Camera3D
@export var sub_viewport: SubViewport
@export var avg_color_debug: ColorRect
@export var dark_threshold: float = 0.001
@export var update_tick: float = 0.1
@export var player_light: OmniLight3D

@export var debug_is_dark: bool:
	get:
		return is_in_darkness()


@onready var viewport_camera = sub_viewport.get_camera_3d()

var light_level: float = 0.0

func _ready():
	if not OS.is_debug_build():
		avg_color_debug.visible = false
	
	_update()

func _update():
	if is_processing():
		get_light_level()
		var t = 1.0 - light_level
		player_light.light_energy = t
		await get_tree().create_timer(update_tick).timeout.connect(_update)

func _process(delta):
	# It does not updates automatically
	self.global_position = player.global_position
	self.global_rotation = player.global_rotation
	self.viewport_camera.fov = player_camera.fov
	
	if Input.is_action_just_pressed("hook"):
		var texture = sub_viewport.get_texture()
		texture.get_image().save_png('res://tmp/test.png')
	
	player_light.visible = is_in_darkness()

func get_light_level():
	var texture = sub_viewport.get_texture()
	var avg_color = get_average_color(texture)
	light_level = avg_color.get_luminance()
	
	avg_color_debug.color = avg_color
	


func get_average_color(texture: ViewportTexture) -> Color:
	var image = texture.get_image()
	image.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	return image.get_pixel(0, 0)


func is_in_darkness(dark_threshold=self.dark_threshold):
	return light_level < dark_threshold
