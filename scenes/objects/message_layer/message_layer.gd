extends CanvasLayer

@onready var _message_label = $MessageLabel
var _message_queue : Array


# Вызывая сообщение, добавляем в очередь
# Показываем сообщение из очереди, удаляем его
# Показываем другие сообщения из очереди, пока она не опустеет

func message(text : String):
	pass

