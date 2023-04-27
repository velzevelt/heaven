extends Node

enum SupportedSdk {
	NoSdk,
	Yandex
}

var sdk = SupportedSdk.NoSdk


func _ready():
	if OS.get_name() != "Web":
		return
	
	match sdk:
		SupportedSdk.Yandex:
			sdk = YandexSdk.new()
			# test ads
			#sdk.show_fullscreen_adv()
	
