extends Label


func _ready():
	var temp = MapData.new()
	text = tr(text)
	text += " " + temp.game_version

