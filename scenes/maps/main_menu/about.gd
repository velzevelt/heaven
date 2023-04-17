extends Button

@onready var about_block: Control = $%AboutBlock


func _ready():
	about_block.visible = false
	pressed.connect(_on_pressed)
	

func _on_pressed():
	about_block.visible = !about_block.visible
