extends Node3D

var height : int = 0

var loaded : bool = false

var serveHeight : int = 3

var tinking : bool = false

var tink : int = 1

var fast : bool = false

var fastBeat : float = 0.0

signal ballHeight(height)

func _ready():
	pass
	#_serve(4)


func _physics_process(delta):
	pass

func _changeBallHeight(height):
	if height == 4:
		
		$Path3D.height = 3
		emit_signal("ballHeight",3)
		
		return
	
	if height == 3:
		$Path3D.height = 2
		emit_signal("ballHeight",2)
		fast = true
		fastBeat = round(GlobalValues.songInBeats)
		return
	
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
	
	
	if position == fastBeat and fast == true:
		_changeBallHeight(4)
	
	if position == fastBeat + 2 and fast == true:
		
		_changeBallHeight(0)
		fast = false
	
	if position == 6:
		_serve(2)
		$Whistle.play()
	
	


func _serve(length):
	$Path3D/PathFollow3D/CharacterBody3D.startServing = true
	$Path3D/PathFollow3D/CharacterBody3D.serveBeat = round(GlobalValues.songInBeats)
	$Path3D/PathFollow3D/CharacterBody3D.serveLength = length
	$Path3D.height = 4
	$Path3D.rotation_degrees.y = 0


func _on_character_body_3d_serve_done():
	height = serveHeight
	_changeBallHeight(serveHeight)
