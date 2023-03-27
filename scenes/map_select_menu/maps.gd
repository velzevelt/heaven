extends VBoxContainer

signal map_selected(map_data: MapData)
signal map_container_selected(map_collection: MapCollection)

@export var map_item: PackedScene = preload("res://scenes/map_select_menu/map_item.tscn")
@export var map_container_item: PackedScene = preload("res://scenes/map_select_menu/map_container.tscn")


func _ready():
	var map_packs = SceneLoader._map_packs
	for map_pack in map_packs:
		var pack = map_container_item.instantiate()
		pack.get_child(0).text = map_pack.visible_name
#		pack.map_collection = pack
#		pack.container_pressed.connect(_on_map_container_selected)
		call_deferred('add_child', pack)
		
		for collection in map_pack.map_collections:
			var col = _add_map_container(map_container_item, collection)
			col.get_child(0).text = collection.visible_name
			pack.call_deferred('add_child', col)
			
			for map in collection.maps:
				var t = _add_map_item(map_item, map)
				col.call_deferred('add_child', t)
			


func _add_map_container(map_container: PackedScene, map_collection: MapCollection):
	var item = map_container.instantiate() as MapContainer
	item.map_collection = map_collection
	item.container_pressed.connect(_on_map_container_selected)
	return item


func _on_map_container_selected(map_collection):
	map_container_selected.emit(map_collection)



@warning_ignore("shadowed_variable")
func _add_map_item(map_item: PackedScene, map_data: MapData):
	if not map_data.hidden:
		if not OS.is_debug_build() and map_data.map_tags.has('debug'):
			return
		
		var item = map_item.instantiate() as MapItem
		item.map_data = map_data
		item.item_selected.connect(_on_map_item_selected)
		return item


func _on_map_item_selected(map_data):
	map_selected.emit(map_data)

