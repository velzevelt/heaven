extends Label


func _ready():
	var temp = MapData.new()
	text += " " + temp.engine_version
