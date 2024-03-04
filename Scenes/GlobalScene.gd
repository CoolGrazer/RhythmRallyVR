extends Node3D

var height : int = 1

var loaded : bool = false

signal ballHeight(height)

func _ready():
	pass
	#_serve(4)


func _physics_process(delta):
	if Input.is_key_pressed(KEY_0):
		_serve(4.0)

func _changeBallHeight(height):
	$Path3D.height = height
	
	if $Path3D/PathFollow3D/CharacterBody3D.served == true:
		emit_signal("ballHeight",height)
	


func _on_audio_stream_player_beat(position):
	
	if position == 16:
		height = 0
		_changeBallHeight(height)


func _serve(length):
	$Path3D/PathFollow3D/CharacterBody3D.startServing = true
	$Path3D/PathFollow3D/CharacterBody3D.serveBeat = round(GlobalValues.songInBeats)
	$Path3D/PathFollow3D/CharacterBody3D.serveLength = length
	$Path3D.loadCurve(4)
