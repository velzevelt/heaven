@tool
class_name Map
extends Node3D

@export var goal_storage: MapGoalStorage


var map_finish_menu: PackedScene = preload("res://scenes/map_finish_menu/map_finish_menu.tscn")
var map_escape_menu: PackedScene = preload("res://scenes/map_escape_menu/map_escape_menu.tscn")


var _map_finish_menu_instance
var _map_escape_menu_instance


func _ready():
	if not Engine.is_editor_hint():
		Settings.hide_cursor()
		Events.player_finished.connect(_on_player_finished)


func _get_map_data() -> MapData:
	# velz/heaven/tutorial.tscn -> velz/heaven/map_data.tres
	var map_data_path = scene_file_path.get_base_dir() + "/" + SceneLoader.MAP_DATA_FILE_NAME
	
	if ResourceLoader.exists(map_data_path):
		var map_data = load(map_data_path) as MapData
		if map_data is MapData:
			return map_data
		else:
			Logger.debug_log("%s can't cast to MapData. Wrong .tres resource?", MESSAGE_TYPE.ERROR)
			return null
	else:
		var error_message = "Can't find map_data %s" % map_data_path
		error_message += "Be sure that map_scene file and map_data file both exist"
		Logger.debug_log(error_message, MESSAGE_TYPE.ERROR)
		return null


func _on_player_finished():
	_map_finish_menu_instance = MenuComponent.create_menu(map_finish_menu)
	
	var map_goals = []
	if is_instance_valid(goal_storage):
		map_goals = goal_storage.goals
	
	_map_finish_menu_instance.map_goals = map_goals
	
	var map_data = _get_map_data()
	if map_data != null:
		if not map_data.next_map_path.is_empty():
			if ResourceLoader.exists(map_data.next_map_path):
				_map_finish_menu_instance.next_map = load(map_data.next_map_path)
			else:
				Logger.debug_log("%s map path is not valid anymore, update map_data" % map_data.next_map_path, MESSAGE_TYPE.WARNING)
		else:
			Logger.debug_log("%s map missing next map path" % map_data.resource_path, MESSAGE_TYPE.WARNING)
	
	call_deferred('add_child', _map_finish_menu_instance )


func _unhandled_input(_event):
	if Input.is_action_just_pressed('ui_cancel') and not is_instance_valid(_map_escape_menu_instance):
		_map_escape_menu_instance = MenuComponent.open_menu(map_escape_menu, self)
