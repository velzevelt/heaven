@tool
extends Node

signal coin_collected

func _ready():
	update_configuration_warnings()
	
	self.coin_collected.connect(_on_coin_collected)
	
	for c in get_children():
		if c.has_signal('picked_up'):
			c.connect('picked_up', func(): coin_collected.emit())
		else:
			Logger.debug_log('Missing PickUp signal!', MESSAGE_TYPE.WARNING)


func _get_configuration_warnings():
	for c in get_children():
		if not c is Coin:
			return ['Non Coin child found']

func _on_coin_collected():
	pass
