@tool
class_name SceneLoaderStatic
extends Node

const MAP_PACK_FILE_NAME = 'map_pack.tres'
const MAP_COLLECTION_FILE_NAME = 'map_collection.tres'
const MAP_DATA_FILE_NAME = 'map_data.tres'
const MAP_SCENE_FILE_NAME = 'map.tscn'

var _maps_path: String = "res://scenes/maps"

@warning_ignore("unused_private_class_variable")
var _map_packs: Array


func _ready():
	if not Engine.is_editor_hint():
		@warning_ignore("static_called_on_instance")
		_map_packs = SceneLoaderStatic.load_resources(_maps_path, MAP_PACK_FILE_NAME)



static func load_resources(path: String, resource_name: String):
	# Godot add .remap on the end of exported files
	if not OS.has_feature('editor') and not resource_name.ends_with('.remap'):
		resource_name += '.remap'
	
	var result = []
	var dir = DirAccess.open(path)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while not file_name.is_empty():
			var file_path = path + "/" + file_name
			
			if dir.current_is_dir():
				result.append_array(load_resources(file_path, resource_name))
			else:
				if file_name == resource_name:
					
					# Godot add .remap on the end of exported files, but ResourceLoader cannot recognize those files
					# Need trim from .remap from end to fix it
					if not OS.has_feature('editor') and file_name.ends_with('.remap'):
						file_path = file_path.trim_suffix('.remap')
					
					if ResourceLoader.exists(file_path):
						var data = ResourceLoader.load(file_path)
						result.append(data)
					else:
						if Engine.is_editor_hint():
							push_error("Can't load at %s file does't exist" % file_path)
						else:
							Logger.debug_log("Can't load at %s file does't exist" % file_path, MESSAGE_TYPE.ERROR)
			
			file_name = dir.get_next()
	else:
		
		if Engine.is_editor_hint():
			push_error("Can't open scenes at " + path)
		else:
			Logger.debug_log("Can't open scenes at " + path, MESSAGE_TYPE.ERROR)
	
	return result



func change_scene(scene: MapData):
	var map = scene.map_packed
	if map != null:
		get_tree().change_scene_to_packed(map)
	else:
		Logger.debug_log("Missing map_packed " + scene.resource_path, MESSAGE_TYPE.ERROR)


func reload_scene():
	get_tree().reload_current_scene()
#	breakpoint


