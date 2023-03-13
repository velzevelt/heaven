## Second level of map hierarchy
## MapPack -> MapCollection -> MapData
@tool
class_name MapCollection
extends Resource

@export var visible_name := 'Unnamed MapCollection'
@export_range(0, 10, 1) var show_order := 0

@export var update_maps := false:
	set(_value):
		update_maps = false
		
		if Engine.is_editor_hint():
			maps.clear()
			print(resource_path.get_base_dir())
			maps = MapPack.load_resources_sorted(resource_path.get_base_dir(), SceneLoader.MAP_DATA_FILE_NAME)
		
@export var maps: Array

@export var hidden := false


