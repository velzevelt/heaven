extends Label


func _ready():
	var temp = MapData.new()
	text += " " + temp.game_version

