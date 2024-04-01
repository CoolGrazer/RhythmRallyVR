extends Panel

func _physics_process(delta):
	#print(global_position.x)
	$Label.text = str((position.x) / 54)
	if fmod(position.x / 54,4) == 0:
		modulate = Color.YELLOW
	else:
		modulate = Color.WHITE
	#print(fmod(global_position.x,50))
	#print(str((global_position.x - 4) / 50))
