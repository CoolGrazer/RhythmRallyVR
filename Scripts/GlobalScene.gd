extends Node3D

var height : int = 0

var loaded : bool = false

var serveHeight : int = 1

var tinking : bool = false

var tink : int = 1

var fast : bool = false

var fastBeat : float = 0.0



var lastBeat : float = 0.0

var length : float = 0.0

var colors = [Color.SALMON,Color.AQUA]

var xr_interface: XRInterface

signal ballHeight(height)
signal seriousMode
signal goofyMode


func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")



func _physics_process(delta):
	pass
	

func _changeBallHeight(height):
	if height == 4:
		tinking = false
		$Path3D.height = 2
		emit_signal("ballHeight",4)
		
		return
	
	
	if height == 2:
		tinking = false
	
	$Path3D.height = height
	
	emit_signal("ballHeight",height)
	


func _on_audio_stream_player_beat(position):
	return
	if position == 2:
		_serve(2)
		$Paddler/AnimationPlayer2.play("Ready2")
		$Whistle.play()
	
	if position == 10:
		tinking = true
	if position == 11.5:
		tinking = false
	
	if position == 12:
		_changeBallHeight(4)
	
	
	if position == 14:
		$Pivot._goTowards(92,4,-2.4)
	
	if position == 20:
		tinking = true
		tink = 1
	
	if position == 24:
		_changeBallHeight(2)
	
	if position == 36:
		_changeBallHeight(0)
		
	
	if position == 40:
		_changeBallHeight(1)
		$Pivot._goTowards(340,4,-2.4)
	
	if position == 44:
		tinking = true
	 
	if position == 48:
		_changeBallHeight(2)
	
	if position == 68:
		_changeBallHeight(0)
		$Pivot._goTowards(45,4,-2.4)
	
	if position == 70:
		tinking = true
	
	if position == 72:
		_changeBallHeight(2)
	
	if position == 74:
		_changeBallHeight(0)
		$Pivot._goTowards(88,4,-2.4)
	
	if position == 82:
		_changeBallHeight(1)
		
		
	
	if position == 84:
		tinking = true
		$Pivot._goTowards(160,6,-2.4)
	
	if position == 90:
		_changeBallHeight(2)
		
	
	if position == 96:
		_changeBallHeight(0)
	
	if position == 128:
		_changeBallHeight(1)
		$Pivot._goTowards(92,8,-2.4)
	
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
	
	if position == 190:
		_seriousMode()
	
	if tinking == true:
		if tink == 0:
			tink = 1
			$Tink.play()
		elif tink == 1:
			tink = 0
			$Tonk.play()
	


func restart():
	tinking = false
	$Player/AnimationPlayer2.stop()
	$Paddler/AnimationPlayer2.stop()
	$Path3D/PathFollow3D.progress_ratio = 0.0
	$Path3D/PathFollow3D/CharacterBody3D.hide()
	$Path3D/PathFollow3D/CharacterBody3D._restart()

func _serve(length):
	
	$Path3D/PathFollow3D/CharacterBody3D.startServing = true
	$Path3D/PathFollow3D/CharacterBody3D.serveBeat = round(GlobalValues.songInBeats)
	$Path3D/PathFollow3D/CharacterBody3D.serveLength = length
	$Path3D.height = 4
	$Path3D.rotation_degrees.y = 0
	$Whistle.play()


func _on_character_body_3d_serve_done():
	height = serveHeight
	_changeBallHeight(serveHeight)


func _on_character_body_3d_opp_hit():
	pass
	#$WorldEnvironment.environment.background_color = Color.SALMON


func _on_character_body_3d_play_hit():
	pass
	#$WorldEnvironment.environment.background_color = Color.SALMON


func _on_character_body_3d_table_hit():
	pass
	#$WorldEnvironment.environment.background_color = Color.SALMON

func _seriousMode():
	$GongSerious.play()
	emit_signal("seriousMode")
	$WorldEnvironment.environment.background_color = Color(0.25,0.25,0.25)
	$DirectionalLight3D.hide()
	$Path3D/PathFollow3D/CharacterBody3D/CSGSphere3D.material.albedo_color = Color.WHITE
	$Path3D/PathFollow3D/CharacterBody3D/CSGSphere3D.material.emission = Color.WHITE
	$Path3D/PathFollow3D/CharacterBody3D/GPUParticles3D.emitting = false

func _goofyMode():
	emit_signal("goofyMode")



func _on_chart_serve(length):
	_serve(length)
