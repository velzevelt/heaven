extends MenuComponent


@onready var next_map_button = $%NextButton as Button
@onready var goals_panel = $%GoalsPanel as Panel
@onready var goals_container = $%GoalsContainer as Container

var map_goals: Array[MapGoalData]
var next_map: MapData


func custom_exit():
	Globals.pause_off()
	var escape_menu = MapEscapeMenu.new()
	escape_menu.custom_exit()


func _on_replay_button_pressed():
	Globals.pause_off()
	SceneLoader.reload_scene()


func _on_next_button_pressed():
	Globals.pause_off()
	if next_map is MapData:
		SceneLoader.change_scene(next_map)
	else:
		Logger.debug_log("Null map", MESSAGE_TYPE.ERROR)


func _ready():
	Globals.pause_on()
	Settings.show_cursor()
	
	if next_map == null:
		next_map_button.hide()
	
	if map_goals.size() != 0:
		for goal in map_goals:
			var label = Label.new()
			label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			
			if goal.completed:
				label.text = "%s: %s" % [goal.visible_name, "Completed"]
			else:
				label.text = "%s: %s. Progress: %s" % [goal.visible_name, goal.goal_description, goal.progress]
			
			label.add_theme_font_size_override('font_size', 20)
			goals_container.call_deferred('add_child', label)
	else:
		goals_panel.visible = false
