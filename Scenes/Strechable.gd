extends Node2D

func _physics_process(delta):
	$Stretch.material.set_shader_parameter("scaleX",$Stretch.scale.x)
