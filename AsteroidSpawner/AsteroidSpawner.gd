extends Node3D

var cluster_size = 1

var asteroid = preload("res://Asteroid/asteroid.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(.5).timeout
	#_on_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	for i in cluster_size:
		var asteroid_inst = asteroid.instantiate()
		get_parent().add_child(asteroid_inst)
		asteroid_inst.global_position = global_position + Vector3(randf_range(2.0, -2.0),randf_range(2.0, -2.0), 10.0)


func _on_timer_2_timeout():
	cluster_size += 1
