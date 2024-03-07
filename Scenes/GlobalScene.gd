extends Node3D

var height : int = 0

var loaded : bool = false

var serveHeight : int = 1

var tinking : bool = false

var tink : int = 0

signal ballHeight(height)

func _ready():
	pass
	#_serve(4)


func _physics_process(delta):
	pass

func _changeBallHeight(height):
	$Path3D.height = height
	
	emit_signal("ballHeight",height)
	


func _on_audio_stream_player_beat(position):
	if tinking == true:
		if tink == 0:
			tink = 1
			$Tink.play()
		elif tink == 1:
			tink = 0
			$Tonk.play()
	
	if position == 4:
		_serve(2)
		$Whistle.play()
	
	if position == 14:
		_changeBallHeight(0)
	
	if position == 16:
		tinking = true
	
	if position == 22:
		_changeBallHeight(2)


func _serve(length):
	$Path3D/PathFollow3D/CharacterBody3D.startServing = true
	$Path3D/PathFollow3D/CharacterBody3D.serveBeat = round(GlobalValues.songInBeats)
	$Path3D/PathFollow3D/CharacterBody3D.serveLength = length
	$Path3D.height = 4
	$Path3D.rotation_degrees.y = 0


func _on_character_body_3d_serve_done():
	height = serveHeight
	_changeBallHeight(serveHeight)
