extends Control

#var beautiful = preload("res://Music/Remix 9 (Beautiful One Day) - Rhythm Heaven Fever (ENG Version).mp3")
var beautiful = preload("res://Music/Remix 9 (Beautiful One Day) - Rhythm Heaven Fever (ENG Version).mp3")
var angel = preload("res://Music/Will Wood - Laplace's Angel (Official Video).mp3")
var library = preload("res://Music/nyanyannya  MEIKOFräuleinBiblioteca (フロイラインビブリォチカ)Sub Español.mp3")

var playlist = [[beautiful,130,"From Me! I would KILL for RH!"],[angel,150,"From HER. How did you mispell sick?"],[library,185,"From HER. Weebs together!"]]
var indx = 0

@export var shuffle : bool = false

var playing : bool = false


func _physics_process(delta):
	
	if $AudioStreamPlayer.playing == false and playing == true:
		if indx == playlist.size():
			indx = 0
		elif indx == -1:
			indx = playlist.size() - 1
		$AudioStreamPlayer.stream = playlist[indx][0]
		$AudioStreamPlayer.bpm = playlist[indx][1]
		$AudioStreamPlayer._restart()
		$AudioStreamPlayer.play()
		
		
		if shuffle == true:
			indx = randf_range(0,4)
			return
		indx += 1
	
	if playing == true:
		$RichTextLabel.text = "[center]" +str(covertSecToStandard(abs($AudioStreamPlayer.song_position))) + "/" + str(covertSecToStandard($AudioStreamPlayer.stream.get_length()))
		$HSlider.value = abs($AudioStreamPlayer.song_position) / $AudioStreamPlayer.stream.get_length()
		$RichTextLabel2.text = "[center][wave amp=50.0 freq=6.0]" + playlist[indx-1][2]

func _on_audio_stream_player_beat(position):
	if fmod(position,1) == 0:
		#$Tick.stop()
		$Tick.play()
		get_parent().get_parent().get_parent().get_parent().beatOccured = true

func covertSecToStandard(sec):
	var m = floorf(sec / 60)
	var s = round(fmod(sec,60))
	
	if s < 10:
		return str(m) + ":0" + str(s)
	return str(m) + ":" + str(s)


func _on_button_pressed():
	$AudioStreamPlayer.stop()


func _on_button_2_pressed():
	indx -= 2
	$AudioStreamPlayer.stop()


func _on_button_3_pressed():
	if playing == true:
		$AudioStreamPlayer.stream_paused = true
		playing = false
	else:
		$AudioStreamPlayer.stream_paused = false
		$AudioStreamPlayer.playing = true
		playing = true
	$Button3.hide()
	get_parent().get_parent().get_parent().get_parent().playing = true
