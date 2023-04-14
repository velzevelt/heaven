## Highest level of map hierarchy
## SceneLoader loads only that type
## MapPack -> MapCollection -> MapData 
@tool
class_name MapPack
extends Resource

@export var visible_name := 'Unnamed MapPack'
@export var update_collections := false:
	set(_value):
		update_collections = false
		if Engine.is_editor_hint():
			map_collections.clear()
			map_collections = MapPack.load_resources_sorted(resource_path.get_base_dir(), SceneLoader.MAP_COLLECTION_FILE_NAME)
	get:
		return update_collections

@export var map_collections: Array

@export var hidden := false


static func load_resources_sorted(res_path, res_name):
	if Engine.is_editor_hint():
		var map_dir = res_path
		var unordered_res = SceneLoaderStatic.load_resources(map_dir, res_name)
		var sorted_res = []
		var max_order = 0
		
		for map_collection in unordered_res:
			if map_collection.show_order > max_order:
				max_order = map_collection.show_order
		
		for i in range(0, max_order + 1):
			for map_collection in unordered_res:
				if map_collection.show_order == i:
					sorted_res.append(map_collection)
		
		return sorted_res

@export var tags: PackedStringArray
