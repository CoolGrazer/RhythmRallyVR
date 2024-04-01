extends ColorRect

var beat : float = 0.0
var playing : bool = false

func _physics_process(delta):
	if playing == true:
		beat = GlobalValues.songInBeats
		global_position.x = 177 + (beat * 54)
	elif Input.is_action_just_pressed("AltClick"):
		beat = (get_global_mouse_position().x - 177) / 54
		beat = snapped(beat,0.5)
		get_parent().songPos = (60 / GlobalValues.bpm) * beat
	
	beat = clampf(beat,0,32767)
	
	global_position.x = 177 + (beat * 54)
