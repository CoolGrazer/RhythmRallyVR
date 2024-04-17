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
signal regular
signal slow
signal superfast
signal tinkStart
signal tinkEnd
signal fast
signal victory

func _on_audio_stream_player_beat(position):
	_checkChart(0,position)
	_checkChart(1,position)
	_checkChart(2,position)


# fix that the serve doesn't work after the first time.....
func _checkChart(num,position):
	if num == 0:
		if chart1.size() > indx1 and position == chart1[indx1][0]:
			var string = chart1[indx1][1]
			print(string)
			if string == "serve":
				var length = chart1[indx1][2]
				print("Will serve!")
				emit_signal("serve",length)
			if string == "reg":
				print("Will regular!")
				emit_signal("regular")
			if string == "slow":
				print("Will slow!")
				emit_signal("slow")
			if string == "sFast":
				print("Will superfast!")
				emit_signal("superfast")
			if string == "tinkS":
				print("Will tink!")
				emit_signal("tinkStart")
			if string == "tinkE":
				print("Will not tink!")
				emit_signal("tinkEnd")
			if string == "fast":
				print("Will fast!")
				emit_signal("fast")
			if string == "victory":
				print("Will pose for the fans!")
				emit_signal("victory")
			indx1 += 1
	elif num == 1:
		if chart2.size() > indx2 and position == chart2[indx2][0]:
			
			var string = chart2[indx2][1]
			print(string)
			if string == "serve":
				var length = chart1[indx2][2]
				print("Will serve!")
				emit_signal("serve",length)
			if string == "reg":
				print("Will regular!")
				emit_signal("regular")
			if string == "slow":
				print("Will slow!")
				emit_signal("slow")
			if string == "sFast":
				print("Will superfast!")
				emit_signal("superfast")
			if string == "tinkS":
				print("Will tink!")
				emit_signal("tinkStart")
			if string == "tinkE":
				print("Will not tink!")
				emit_signal("tinkEnd")
			if string == "fast":
				print("Will fast!")
				emit_signal("fast")
			if string == "victory":
				print("Will pose for the fans!")
				emit_signal("victory")
			indx2 += 1
	elif num == 3:
		if chart3.size() > indx3 and position == chart3[indx3][0]:
			var string = chart3[indx3][1]
			print(string)
			if string == "serve":
				var length = chart1[indx3][2]
				print("Will serve!")
				emit_signal("serve",length)
			if string == "reg":
				print("Will regular!")
				emit_signal("regular")
			if string == "slow":
				print("Will slow!")
				emit_signal("slow")
			if string == "sFast":
				print("Will superfast!")
				emit_signal("superfast")
			if string == "tinkS":
				print("Will tink!")
				emit_signal("tinkStart")
			if string == "tinkE":
				print("Will not tink!")
				emit_signal("tinkEnd")
			if string == "fast":
				print("Will fast!")
				emit_signal("fast")
			if string == "victory":
				print("Will pose for the fans!")
				emit_signal("victory")
			indx3 += 1
