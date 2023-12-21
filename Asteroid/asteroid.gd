extends CharacterBody3D
var scale_

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	scale_ = 1.0
	scale = Vector3(0,0,0)
	$Model/Sphere.material_override.albedo_color = Color.from_hsv(randf_range(0, 100)/100, 0.36, 0.26, 1.0)
	create_tween().tween_property(self, 'scale', Vector3(scale_, scale_, scale_), 1.0)
	velocity = Vector3(randf_range(-0.1, 0.1), randf_range(-0.1, 0.1), randf_range(-0.0, -0.2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()


func _on_timer_timeout():
	queue_free()
