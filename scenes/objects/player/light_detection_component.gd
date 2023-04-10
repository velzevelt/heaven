extends Node3D

signal darkness_entered
signal darkness_exited

@export var player_camera: Camera3D
@export var sub_viewport: SubViewport
@export var average_color_debug: ColorRect
@export var dark_threshold: float = 0.001
@export var player_light: OmniLight3D

@onready var viewport_camera = sub_viewport.get_camera_3d()

var light_level: float = 0.0

var is_dark: bool:
	get:
		return is_dark
	set(value):
		if value != is_dark:
			is_dark = value
			if is_dark: 
				darkness_entered.emit()
			else:
				darkness_exited.emit()

var tween: Tween

func _ready():
	if not OS.is_debug_build() and is_instance_valid(average_color_debug):
		average_color_debug.visible = false
	
	darkness_entered.connect(_on_darkness_entered)
	darkness_exited.connect(_on_darkness_exited)
	
	player_light.light_energy = 0.0 # disable light by default


func _on_darkness_entered():
	tween = create_tween()
	tween.tween_interval(2.0)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(player_light, 'light_energy', 1.0, 2.0)


func _on_darkness_exited():
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(player_light, 'light_energy', 0.0, 0.3)


func _physics_process(_delta):
	# It does not updates automatically
	self.global_position = player_camera.global_position
	self.global_rotation = player_camera.global_rotation
	self.viewport_camera.fov = player_camera.fov
	
	get_light_level()
	self.is_dark = is_in_darkness()
	
	if OS.is_debug_build():
		# Debugging lighting texture
		if Input.is_action_just_pressed("hook"):
			var texture = sub_viewport.get_texture()
			texture.get_image().save_png('res://tmp/lighting.png')


func get_light_level():
	var texture = sub_viewport.get_texture()
	var average_color = get_average_color(texture)
	light_level = average_color.get_luminance()


func get_average_color(texture: ViewportTexture) -> Color:
	var image = texture.get_image()
	image.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	return image.get_pixel(0, 0)


@warning_ignore("shadowed_variable")
func is_in_darkness(dark_threshold=self.dark_threshold):
	return light_level < dark_threshold
