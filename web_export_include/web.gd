extends Node

enum SupportedSdk {
	Yandex
}

var sdk = SupportedSdk.Yandex


func _ready():
	if OS.get_name() != "Web":
		return
	
	match sdk:
		SupportedSdk.Yandex:
			sdk = YandexSdk.new()
			sdk.show_fullscreen_adv()
	
