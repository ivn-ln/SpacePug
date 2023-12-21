extends Node3D

@export var is_display = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_display:
		$AsteroidSpawner.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_display:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Camera3D.global_position.z = $Player.global_position.z -3
	if not is_display:
		$AsteroidSpawner.global_position.z = $Player.global_position.z
	$MeshInstance3D.global_position.z = $Player.global_position.z
