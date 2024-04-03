extends Node

var chart1 = [[0,"gec"]]
var chart2 = []
var chart3 = []
var chart4 = []

var indx1 : int = 0
var indx2 : int = 0
var indx3 : int = 0
var indx4 : int = 0

signal serve(length)

func _on_audio_stream_player_beat(position):
	if chart1.size() > indx1 and position == chart1[indx1][0]:
		var string = chart1[indx1][1]
		if string == "serve":
			var length = chart1[indx1][2]
			print("Will serve!")
			emit_signal("serve",length)
			
		indx1 += 1


# fix that the serve doesn't work after the first time.....
