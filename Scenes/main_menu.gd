extends Control

@onready var option = $Panel
@onready var slider = $Panel/VBoxContainer/HSlider
@onready var mute = $Panel/VBoxContainer/HBoxContainer/HBoxContainer/CheckButton
@onready var fullScreen = $Panel/VBoxContainer/HBoxContainer/HBoxContainer2/CheckButton2

var bus_index = AudioServer.get_bus_index("Master")

func _ready() -> void:
	var is_muted = AudioServer.is_bus_mute(bus_index)
	var mode = DisplayServer.window_get_mode()
	fullScreen.button_pressed = (mode == DisplayServer.WINDOW_MODE_FULLSCREEN)
	mute.button_pressed = not is_muted

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Map/Map.tscn")

func _on_button_2_pressed() -> void:
	option.visible = true
	slider.scrollable = true
	mute.disabled = false
	fullScreen.disabled = false

func _on_button_3_pressed() -> void:
	get_tree().quit()

func _on_button_4_pressed() -> void:
	option.visible = false
	slider.scrollable = false
	mute.disabled = true
	fullScreen.disabled = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(bus_index, not AudioServer.is_bus_mute(bus_index))

func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
