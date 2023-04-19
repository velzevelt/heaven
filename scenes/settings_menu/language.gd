extends OptionButton


func _ready():
	match TranslationServer.get_locale():
		'en':
			select(0)
		'ru':
			select(1)
		_:
			select(0)
	
	item_selected.connect(_on_item_selected)

func _on_item_selected(index):
	match index:
		0:
			TranslationServer.set_locale('en')
		1:
			TranslationServer.set_locale('ru')
		_:
			TranslationServer.set_locale('en')
