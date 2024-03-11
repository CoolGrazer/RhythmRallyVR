extends Node3D

var height : int = 0

var loaded : bool = false

var serveHeight : int = 1

var tinking : bool = false

var tink : int = 1

var fast : bool = false

var fastBeat : float = 0.0

var startLerp : bool = false


var lastBeat : float = 0.0

var length : float = 0.0

signal ballHeight(height)

func _ready():
	pass
	#_serve(4)


func _physics_process(delta):
	if startLerp == true:
		$WorldEnvironment.environment.background_color = lerp(Color.ORANGE,Color.RED,GlobalValues.posFromBeat(44,28,false) / 28)
	
	
	

func _changeBallHeight(height):
	if height == 4:
		
		$Path3D.height = 3
		emit_signal("ballHeight",3)
		
		return
	
	if height == 3:
		tinking = false
		$Path3D.height = 2
		emit_signal("ballHeight",2)
		fast = true
		fastBeat = round(GlobalValues.songInBeats)
		return
	
	
	if height == 2:
		tinking = false
	
	$Path3D.height = height
	
	emit_signal("ballHeight",height)
	


func _on_audio_stream_player_beat(position):
	
	if position == fastBeat and fast == true:
		_changeBallHeight(4)
	
	if position == fastBeat + 2 and fast == true:
		
		_changeBallHeight(0)
		fast = false
	
	if position == 3:
		_serve(1)
		$Whistle.play()
	
	if position == 10:
		tinking = true
	
	
	if position == 12:
		_changeBallHeight(2)
	
	
	if position == 14:
		_changeBallHeight(0)
		$Pivot._goTowards(90,4)
	
	if position == 22:
		tinking = true
	
	if position == 26:
		_changeBallHeight(2)
	
	if position == 36:
		_changeBallHeight(0)
		
	
	if position == 40:
		_changeBallHeight(1)
		$Pivot._goTowards(340,4)
	
	if position == 44:
		tinking = true
	 
	if position == 48:
		_changeBallHeight(2)
	
	if position == 68:
		_changeBallHeight(0)
		$Pivot._goTowards(45,4)
	
	if position == 70:
		tinking = true
	
	if position == 72:
		_changeBallHeight(2)
	
	if position == 74:
		_changeBallHeight(0)
		$Pivot._goTowards(90,4)
	
	if position == 82:
		_changeBallHeight(1)
		
		
	
	if position == 84:
		tinking = true
		$Pivot._goTowards(160,6)
	
	if position == 90:
		_changeBallHeight(2)
		
	
	if position == 96:
		_changeBallHeight(0)
	
	if position == 128:
		_changeBallHeight(1)
		$Pivot._goTowards(90,8)
	
	if position == 136:
		_changeBallHeight(0)
	
	if position == 144:
		tinking = true
	
	if position == 148:
		_changeBallHeight(2)
	
	if position == 156:
		_changeBallHeight(0)
	
	if position == 160:
		_changeBallHeight(1)
	
	if position == 176:
		_changeBallHeight(0)
	
	if position == 180:
		tinking = true
	
	if position == 184:
		_changeBallHeight(2)
	
	if tinking == true:
		if tink == 0:
			tink = 1
			$Tink.play()
		elif tink == 1:
			tink = 0
			$Tonk.play()
	
	
	
	


func _serve(length):
	$Path3D/PathFollow3D/CharacterBody3D.startServing = true
	$Path3D/PathFollow3D/CharacterBody3D.serveBeat = round(GlobalValues.songInBeats)
	$Path3D/PathFollow3D/CharacterBody3D.serveLength = length
	$Path3D.height = 4
	$Path3D.rotation_degrees.y = 0


func _on_character_body_3d_serve_done():
	height = serveHeight
	_changeBallHeight(serveHeight)
