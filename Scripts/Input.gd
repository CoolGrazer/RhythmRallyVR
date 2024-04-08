extends Node

@export var autoBot : bool = false

var served : bool = false

signal hit

func _process(delta):
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