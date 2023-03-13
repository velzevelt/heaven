extends RichTextLabel


func _ready() -> void:
	text = ''
	Logger.message_entered.connect(_on_log)

func _on_log(message) -> void:
	text += message + "\n"



