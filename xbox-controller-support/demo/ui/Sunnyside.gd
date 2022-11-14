extends VBoxContainer

onready var button = $MarginContainer/Control/Node2D/DownloadButton

func _on_DownloadButton_button_down():
	OS.shell_open("https://danieldiggle.itch.io/sunnyside")
	button.release_focus()
