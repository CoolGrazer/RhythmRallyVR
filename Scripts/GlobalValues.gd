extends Node


var relativeBeat : float = 0.0
var songInBeats : float = 0.0
var bpm : float = 120.0
var beatDurs : float = 0.0
var hitBeat : float = 0.0


func posFromBeat(startBeat,length,beatClamp):
	var beat = songInBeats
	
	
	if beatClamp:
		beat = max(beat,0)
	
	
	var a = clampf(beat,startBeat,startBeat + length)
	return a - startBeat

