extends Node

@export var autoBot : bool = false
@export var calibration : bool = false

var served : bool = false

signal hit
# Used only for calibration
var caliBeat : int = 0
var caliAvg : float = 0.0
var inputs : int = 0
var justPressed : bool = false

func _process(delta):
	
	
	if calibration == true:
		if GlobalValues.songInBeats > caliBeat + 0.3:
			caliBeat += 1
		var offset = getOffset(caliBeat)
		if justPressed == true:
			justPressed = false
			caliAvg += offset
			inputs += 1
			
		return
	else:
		served = get_parent().get_child(7).get_child(0).get_child(0).served
	
	
	if served == true:
		var offset = getOffset(GlobalValues.hitBeat + GlobalValues.beatDurs)
		#print_rich("[color=green]" + str(offset) + "[/color]")
		if abs(offset) < 0.1:
			#emit_signal("hit")
			pass
	
	


func getOffset(beat):
	return GlobalValues.songInBeats - beat

func _calculateRating():
	pass

# Use signals to use CharacterBody3D and do the _hit() / _barely() / _miss()


func _on_right_controller_button_pressed(name):
	if name == "ax_button":
		justPressed = true
