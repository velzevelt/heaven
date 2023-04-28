#class_name YandexSdk
extends Node


func _ready():
	if not OS.has_feature('JavaScript'):
		Logger.debug_log('Platform does not has JavaScript. YandexSdk not initialized', MESSAGE_TYPE.WARNING)
		queue_free()
	
	Events.fullscreen_adv_requested.connect(show_fullscreen_adv)


func show_fullscreen_adv():
	Logger.debug_log('Ads shoud be showen')
	JavaScriptBridge.eval('showFullScreenAdv()')
