extends CanvasLayer

@export_range(0.1, 4.0, 0.1) var anim_duration := 1.5
@export_range(100, 5000, 50) var offset_value := 500

@export_range(0.1, 10.0, 0.1) var delay_to_hide := 1.5
@onready var init_offset = self.offset
var appeared = false


func _ready():
	offset.x += offset_value
	await animate(init_offset).finished
	appeared = true


func animate(new_offset):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, 'offset', new_offset, anim_duration)
	return tween
