extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CheckButton.button_pressed = Globals.inverse_controls
	$HSlider.value = Globals.sound_volume + 90


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file('res://Test/test.tscn')


func _on_check_button_pressed():
	Globals.inverse_controls = true
	


func _on_h_slider_value_changed(value):
	Globals.sound_volume = value - 90


func _on_button_2_pressed():
	get_tree().quit()


func _on_button_3_pressed():
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
