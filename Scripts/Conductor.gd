extends AudioStreamPlayer

@export var bpm : float = 100
@export var msOffset : float = 0

# Tracking the beat and song position
var song_position = 0.0
var song_position_in_beats = 0
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
@export var beats_before_start = 0

# Determining how close to the beat an event is
var closest = 0
var time_off_beat = 0.0

signal beat(position)


func _ready():
	sec_per_beat = 60.0 / bpm
	GlobalValues.bpm = bpm
	seek(msOffset / 1000.0)
	emit_signal("beat",0)


func _process(_delta):
	if playing:
		
		
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = floorTo(song_position / sec_per_beat,0.5) + beats_before_start
		
		GlobalValues.songInBeats = (song_position / sec_per_beat)
		
		
		_report_beat()

func _report_beat():
	if last_reported_beat < song_position_in_beats:
		emit_signal("beat", song_position_in_beats)
		last_reported_beat = song_position_in_beats
		



func play_with_beat_offset(num):
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()


func closest_beat(nth):
	closest = int(round((song_position / sec_per_beat) / nth) * nth) 
	time_off_beat = abs(closest * sec_per_beat - song_position)
	return Vector2(closest, time_off_beat)


func _restart():
	last_reported_beat = 0

func play_from_beat(_beat, offset):
	play()
	seek(_beat * sec_per_beat)
	beats_before_start = offset


func floorTo(val,snap):
	
	if snapped(val,snap) > val:
		return snapped(val,snap) - snap
	else:
		return snapped(val,snap)

