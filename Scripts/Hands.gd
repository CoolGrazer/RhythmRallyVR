extends XRController3D

var velocity : Vector3


var lastPos = Vector3.ZERO
@export var right = false

var bufferedSwing : bool = false
@export var framesOfSwing : int = 5
@export var recoveryFrames : int = 10 

var frameTimer : int = -1
var recoveryTimer : int = -1

var swinging : bool = false

var justReleased : bool = false

var held : bool = false


func _physics_process(_delta):
	velocity = lastPos - global_position
	justReleased = false
	
	if !is_button_pressed("trigger_click") and held == true:
		justReleased = true
	
	
	if _canSwing() and justReleased == true:
		swinging = true
		frameTimer = framesOfSwing
		$AudioStreamPlayer.play()
	
	
	held = is_button_pressed("trigger_click")
	
	if frameTimer > 0:
		frameTimer -= 1
	elif frameTimer == 0:
		frameTimer = -1
		recoveryTimer = recoveryFrames
		swinging = false
	
	if recoveryTimer > 0:
		
		recoveryTimer -= 1
	elif recoveryTimer == 0:
		recoveryTimer = -1
		
	
	
	
	lastPos = global_position


func _canSwing():
	return (abs(velocity.x) + abs(velocity.z)) / 2 > 0.005 and right == true and swinging == false and recoveryTimer < 0 and frameTimer < 0
