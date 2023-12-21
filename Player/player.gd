extends CharacterBody3D


@export var top_left_limit = Vector2()
@export var bot_right_limit = Vector2()
@export var circular_boundary_radius = 2.0
var speed = 100.0
var distance = 0.0
@export var display = false


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if not display:
		$CanvasLayer/Control2.show()


func _physics_process(delta):
	global_position.x = clamp(global_position.x, top_left_limit.x, bot_right_limit.x)
	global_position.y = clamp(global_position.y, top_left_limit.y, bot_right_limit.y)
	velocity = basis.z * delta * speed
	speed += delta
	var offset_from_center : Vector2 = Vector2(global_position.x, global_position.y)
	if offset_from_center.length() > circular_boundary_radius:
		offset_from_center = offset_from_center.normalized() * circular_boundary_radius
		global_position.x = offset_from_center.x
		global_position.y = offset_from_center.y
	if move_and_collide(velocity * delta):
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		process_mode = Node.PROCESS_MODE_DISABLED
		$CanvasLayer/Control2.hide()
		$CanvasLayer/Control.show()
	distance += delta * speed / 100.0
	$CanvasLayer/Control2/Label.text =  str(floori(distance)) + 'm'
	$CanvasLayer/Control/Label2.text =  str(floori(distance))

func _unhandled_input(event):
	if event.is_class('InputEventMouseMotion'):
		if not Globals.inverse_controls:
			rotation += Vector3(clamp(-event.relative.y, -5, 5), clamp(event.relative.x, -5, 5), 0.0) * 0.005
		else:
			rotation += Vector3(event.relative.y, -event.relative.x, 0.0) * 0.005
		rotation_degrees.y = clamp(rotation_degrees.y, -45, 45)
		rotation_degrees.x = clamp(rotation_degrees.x, -45, 45)


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_button_2_pressed():
	get_tree().change_scene_to_file('res://MainMenu/main_menu.tscn')
