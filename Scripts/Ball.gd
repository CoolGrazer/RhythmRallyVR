extends CharacterBody3D

const tableHitTime : float = 0.58

var back : bool = true

var hitBeat : float = 0.0

var beatDur1 : float = 1.0
var beatDur2 : float = 1.0

var curvePosition : float = 0.0


var tableHit : bool = false

var changedHeight : bool = false

var served : bool = false

var startServing : bool = false

var serveBeat : float = 2.0
var serveLength : float = 2.0

var fast : bool = false
var beatToFast : int = -1
var beatToNormal : int = -1

var hasHit : bool = false

var barely : bool = false
var playerBeat : float = 0.0

signal swingOpp
signal swingPlay
signal readyOpp
signal readyPlay

signal forceFastPath
signal forceNormalPath
signal forceSlowPath
signal forceSuperPath
signal forceBarelyPath
signal forceServe

signal playHit
signal oppHit

signal serveDone

# Serve is still bad oof. Otherwise I'm working on barely's and misses rn so that's neato!

func _ready():
	pass

func _physics_process(delta):
	
	if served == true:
		_physicsTick()
		GlobalValues.beatDurs = beatDur1 + beatDur2
		GlobalValues.hitBeat = hitBeat
	
	if startServing == true:
		_serve(serveBeat,serveLength)
# the issue with serving is that the beat isn't being prop resset lmao :(
func _physicsTick():
	var bakedPos
	
	if barely == true:
		_barelyPath()
		bakedPos = curvePosition
		get_parent().progress_ratio = bakedPos
		return
	
	if changedHeight == false:
		if fast == false:
			_goForward()
			bakedPos = curvePosition / beatDur1
		else:
			_fastRally()
			bakedPos = curvePosition
	else:
		changedHeight = false
	
	get_parent().progress_ratio = bakedPos
	


func _goForward():
	var hitPosition1 = GlobalValues.posFromBeat(hitBeat,beatDur1,false)
	
	show()
	
	if hitPosition1 >= beatDur1:
		if tableHit == false:
			
			_stopAllSources()
			$HitTable.play()
			
			#$AnimationPlayer.play("And")
			if back == true:
				emit_signal("readyPlay")
			else:
				emit_signal("readyOpp")
			
			tableHit = true
		
		
		var hitPosition2 = GlobalValues.posFromBeat(hitBeat + beatDur1, beatDur2,false)
		curvePosition = (hitPosition2 * (1 - tableHitTime)) + (tableHitTime * beatDur1)
			
		# Gotta fix up the FAST rally type.
		
	else:
		curvePosition = hitPosition1 * tableHitTime
		
		
		
	
	if abs(curvePosition) - abs(beatDur2) == 0:
		if back == false:
			_stopAllSources()
			$HitOpp.play()
			#$AnimationPlayer.play("Tonk")
			emit_signal("oppHit")
			emit_signal("swingOpp")
			tableHit = false
			get_parent().get_parent().flip()
			curvePosition = 0
			back = not back
			hitBeat = round(GlobalValues.songInBeats)
			hasHit = false
		else:
			print(round(GlobalValues.songInBeats))
			_hit()
		
		

func _fastRally():
	
	var offsetFromStart = GlobalValues.posFromBeat(hitBeat,beatDur1,false)
	
	if offsetFromStart >= 1.0:
		var offsetFromStart2 = GlobalValues.posFromBeat(hitBeat + 1,beatDur2,false)
		
		if tableHit == false:
			emit_signal("tableHit")
			_stopAllSources()
			$HitTable.play()
			
			#$AnimationPlayer.play("And")
			emit_signal("readyOpp")
			
			tableHit = true
		
		
		curvePosition = (offsetFromStart2 / 4.761904762) + tableHitTime
		
	else:
		curvePosition = offsetFromStart * 0.58

func _barelyPath():
	var hitPosition = GlobalValues.posFromBeat(hitBeat,1,true)
	print(hitPosition)
	curvePosition = hitPosition
	
	

func _on_node_3d_ball_height(height):
	back = true
	if height == 0:
		get_parent().get_parent().flip()
		beatDur1 = 1
		beatDur2 = 1
	elif height == 1:
		get_parent().get_parent().flip()
		beatDur1 = 2
		beatDur2 = 2
	elif height == 2:
		get_parent().get_parent().flip()
		beatDur1 = 0.5
		beatDur2 = 0.5
	elif height == 3:
		get_parent().get_parent().flip()
		beatDur1 = 1
		beatDur2 = 2
	elif height == 4:
		get_parent().get_parent().flip()
		beatDur1 = 0.5
		beatDur2 = 0.5
		beatToFast = round(GlobalValues.songInBeats) + 1
		
	tableHit = false
	emit_signal("swingOpp")
	emit_signal("oppHit")
	#$AnimationPlayer.play("Tonk")
	$HitOpp.play()
	hitBeat = round(GlobalValues.songInBeats)
	


func _stopAllSources():
	$HitPlayer.stop()
	$HitTable.stop()
	$HitOpp.stop()

# Make the serve look not shit thx

func _serve(starting,beatDur):
	var hitPosition1 = GlobalValues.posFromBeat(starting,beatDur,true)
	
	if visible == false:
		
		show()
	
	var bakedPos = hitPosition1 / beatDur
	bakedPos = ease(bakedPos,1.0)
	get_parent().progress_ratio = bakedPos
	if get_parent().progress_ratio == 1.0:
		emit_signal("serveDone")
		get_parent().get_parent().flip()
		startServing = false
		served = true
		hitBeat = round(GlobalValues.songInBeats)
		

func _changeToFast():
	beatDur1 = 1
	beatDur2 = 2
	fast = true
	tableHit = false
	hitBeat = round(GlobalValues.songInBeats)
	get_parent().get_parent().flip()
	$HitPlayer.play()
	beatToNormal = round(GlobalValues.songInBeats) + 3
	emit_signal("swingPlay")
	emit_signal("forceFastPath")
	back = false

func _on_audio_stream_player_beat(position):
	if position == beatToFast:
		_changeToFast()
	if position == beatToNormal:
		tableHit = false
		fast = false
		beatDur1 = 1.0
		beatDur2 = 1.0
		hitBeat = round(GlobalValues.songInBeats)
		get_parent().get_parent().flip()
		$HitOpp.play()
		emit_signal("swingOpp")
		emit_signal("forceNormalPath")
		back = true

func _on_vr_test_ball_height(height):
	back = true
	if height == 0:
		get_parent().get_parent().flip()
		beatDur1 = 1
		beatDur2 = 1
	elif height == 1:
		get_parent().get_parent().flip()
		beatDur1 = 2
		beatDur2 = 2
	elif height == 2:
		get_parent().get_parent().flip()
		beatDur1 = 0.5
		beatDur2 = 0.5
	elif height == 3:
		get_parent().get_parent().flip()
		beatDur1 = 1
		beatDur2 = 2
	elif height == 4:
		get_parent().get_parent().flip()
		beatDur1 = 0.5
		beatDur2 = 0.5
		beatToFast = round(GlobalValues.songInBeats) + 1
		
	tableHit = false
	emit_signal("swingOpp")
	#$AnimationPlayer.play("Tonk")
	$HitOpp.play()
	hitBeat = hitBeat + beatDur1 + beatDur2
	if served == false:
		print("show")
		served = true
		show()


func _barely():
	hasHit = true
	_stopAllSources()
	emit_signal("swingPlay")
	emit_signal("playHit")
	tableHit = false
	curvePosition = 0
	back = not back
	hitBeat = hitBeat + beatDur1 + beatDur2
	emit_signal("forceBarelyPath")
	get_parent().get_parent().flip()
	barely = true

func _miss():
	pass

func _hit():
	hasHit = true
	_stopAllSources()
	$HitPlayer.play()
	#$AnimationPlayer.play("Tink")
	emit_signal("swingPlay")
	emit_signal("playHit")
	tableHit = false
	get_parent().get_parent().flip()
	curvePosition = 0
	back = not back
	hitBeat = hitBeat + beatDur1 + beatDur2

func _restart():
	back = true
	hitBeat = 0.0
	beatDur1 = 1.0
	beatDur2 = 1.0
	curvePosition = 0.0
	tableHit = false
	changedHeight = false
	served = false
	startServing = false
	serveBeat = -1.0
	serveLength = 2.0
	fast = false
	beatToFast = -1
	beatToNormal = -1


func _on_input_hit():
	if hasHit == false:
		_hit()
