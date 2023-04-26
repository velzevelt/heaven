class_name YandexSdk
extends RefCounted


func _init():
	if not OS.has_feature('JavaScript'):
		Logger.debug_log('Platform does not has JavaScript. Sdk not initialized', MESSAGE_TYPE.ERROR)
		


func show_fullscreen_adv():
	Logger.debug_log('Ads shoud be showen')
	JavaScriptBridge.eval('showFullScreenAdv()')
