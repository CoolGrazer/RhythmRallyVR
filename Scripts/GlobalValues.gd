extends Node


var relativeBeat : float = 0.0
var songInBeats : float = 0.0



func posFromBeat(startBeat,length,beatClamp):
	var beat = songInBeats
	
	
	if beatClamp:
		beat = max(beat,0)
	
	
	var a = clampf(beat,startBeat,startBeat + length)
	return a

