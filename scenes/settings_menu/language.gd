extends OptionButton


func _ready():
	match Settings.locale:
		'en':
			select(0)
		'ru':
			select(1)
		_:
			select(0)


