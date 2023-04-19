extends RichTextLabel

func _ready():
	meta_clicked.connect(_on_meta_clicked)

func _on_meta_clicked(url):
	OS.shell_open(url)
