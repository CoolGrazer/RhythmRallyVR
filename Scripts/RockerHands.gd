extends StaticBody3D

var velocity : Vector3

@onready var hand = get_node(get_path_to(get_parent()))
var lastPos = Vector3.ZERO
@onready var area3D = get_node("Area3D")
@export var right = false

var currentInput = ""
var held : bool = false

func _physics_process(_delta):
	velocity = lastPos - hand.global_position
	
	if held == true and !hand.is_button_pressed("trigger_click") and ($A.playing == true or $Bm.playing == true or $G.playing == true):
		_strum()
	
	held = hand.is_button_pressed("trigger_click")
	
	if hand.is_button_pressed("trigger_click") and ($A.playing == true or $Bm.playing == true or $G.playing == true):
		_mute()
	
	
	if hand.is_button_pressed("grip_click"):
		_globalPitch(1.2)
	else:
		_globalPitch(1)
	
	
	for x in area3D.get_overlapping_bodies():
		if !x == self:
			x.contact(velocity)
	

	lastPos = hand.global_position

func _strum():
	if hand.is_button_pressed("by_button"):
		$G.play()
	else:
		$A.play()

func _mute():
	$A.stop()
	$Bm.stop()
	$G.stop()
	$Mute.play()

func _globalPitch(val):
	$A.pitch_scale = val
	$Bm.pitch_scale = val
	$G.pitch_scale = val


func _on_right_button_pressed(name):
	if name == "ax_button":
		_mute()
