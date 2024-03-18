extends Panel

func _physics_process(delta):
	$Label.text = str((position.x) / 50)
	if fmod(position.x / 50,4) == 0:
		modulate = Color.YELLOW
	else:
		modulate = Color.WHITE
	#print(fmod(global_position.x,50))
	#print(str((global_position.x - 4) / 50))
