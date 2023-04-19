extends Label


func _ready():
	var temp = MapData.new()
	text = tr(text)
	text += " " + temp.engine_version
