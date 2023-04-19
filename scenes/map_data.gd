@tool
class_name MapData
extends Resource

var MAP_DATA_FILE_NAME = SceneLoader.MAP_DATA_FILE_NAME # unified name 'map_data.tres'
var MAP_SCENE_FILE_NAME = SceneLoader.MAP_SCENE_FILE_NAME # unified name 'map.tscn'


@export var author: StringName = 'velz':
	set(value):
		var blacklist_chars = ["/", "\\"]
		var last_char = value.right(1)
		if blacklist_chars.has(last_char):
			push_error("Forbidden character %s" % last_char)
		else:
			author = value
	get:
		return author

@export var thumbnail: Texture = preload("res://icon.svg")

@export var game_version: StringName = '':
	get:
		if game_version == null or game_version.is_empty():
			game_version = ProjectSettings.get_setting('application/config/version')
		return game_version

@export var engine_version: StringName = '':
	get:
		if engine_version == null or engine_version.is_empty():
			engine_version = Engine.get_version_info().get('string')
		return engine_version

@export var map_version: StringName = "0.1.0"

@export var map_packed: PackedScene = null:
	set(value):
		map_packed = value
	get:
		if not map_packed:
			# .../tutorial/map.tscn
			var path = resource_path.get_base_dir() + "/" + MAP_SCENE_FILE_NAME
			if ResourceLoader.exists(path):
				return load(path)
			else:
				push_error(path + " Missing map")
				return null
		else:
			return map_packed

@export_range(0.5, 100.0, 0.5) var difficulty: float = 0.5

@export_multiline var description = ''

## Hide from LevelSelector
@export var hidden := false

## Name used in LevelSelector
@export var visible_name: String = 'Unnamed level'

#@export var previous_map_path: String

## map_data
@export_file var next_map_path: String:
	get:
		return next_map_path
	set(value):
#		if Engine.is_editor_hint():
#			var next_map = ResourceLoader.load(value) as MapData
#			if next_map != null:
#				next_map.previous_map_path = resource_path
		next_map_path = value

## Determinates position in LevelSelector. 0 - first map, 1 - second, etc
@export_range(0, 100, 1) var show_order := 0

@export var tags: PackedStringArray

@export var completed := false
