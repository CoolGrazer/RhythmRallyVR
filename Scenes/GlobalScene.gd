extends Node3D

var height : int = 1


signal ballHeight(height)


func _physics_process(delta):
	if Input.is_key_pressed(KEY_0) and !height == 0:
		height = 0
		_changeBallHeight(height)
	elif Input.is_key_pressed(KEY_1) and !height == 1:
		height = 1
		_changeBallHeight(height)
	elif Input.is_key_pressed(KEY_2) and !height == 2:
		height = 2
		_changeBallHeight(height)

func _changeBallHeight(height):
	$Path3D.height = height
	
	emit_signal("ballHeight",height)
	
	if height == 0:
		$Paddler.swingInt = 4
		$Paddler.offset = 0
		$Paddler2.swingInt = 4
		$Paddler2.offset = 2
	elif height == 1:
		$Paddler.swingInt = 8
		$Paddler.offset = 0
		$Paddler2.swingInt = 8
		$Paddler2.offset = 4
	elif height == 2:
		$Paddler.swingInt = 2
		$Paddler.offset = 0
		$Paddler2.swingInt = 2
		$Paddler2.offset = 1


func _on_audio_stream_player_beat(position):
	return
	if fmod(position,8) == 0:
		if height == 1:
			height = 0
		elif height == 0:
			height = 2
		_changeBallHeight(height)
