extends Node2D

@export var length : float = 5
@export var properties = [[0,"serve"]]
@export var text = "Serve"

var beat = 0

@onready var button = get_node("Origin/Button")
@onready var label = get_node("Origin/Button/Label")

var selected : bool = false

var adjText : String = ""

var inMouse : bool = false

var offset : Vector2 = Vector2.ZERO
var ogPosition : Vector2 = Vector2.ZERO
var ogMouse : Vector2 = Vector2.ZERO
var firstAnim : bool = true

var target : Vector2 = Vector2.ZERO

func _ready():
	adjText = text + " "
	button.size.x = length * 50
	$Origin/Button.grab_focus()
	ogPosition += Vector2(0,24)
	selected = true
	global_position = get_global_mouse_position() + Vector2(0,24)


func _physics_process(delta):
	button.size.x = length * 50
	adjText = text + " "
	if Input.is_action_just_pressed("Delete") and selected == true:
		$AnimationPlayer.play("Delete")
	
	$Origin/Button/Label.text = adjText
	
	beat = global_position / 50
	
	
	label.custom_minimum_size.x = button.size.x
	label.position.x = 0
	
	
	if selected == true and firstAnim == false:
		offset.x = snapped(get_global_mouse_position().x - ogMouse.x,50/2)
		offset.y = snapped(get_global_mouse_position().y - ogMouse.y,40)
		
		global_position = ogPosition + offset
		
	
	if $AnimationPlayer.current_animation == "":
		firstAnim = false
	
	
	if inMouse == true and Input.is_action_just_pressed("Click"):
		ogPosition = global_position
		ogMouse = get_global_mouse_position()
		selected = true
		
	
	if Input.is_action_just_released("Click") and (selected == true):
		selected = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	
	


func _on_button_mouse_entered():
	inMouse = true


func _on_button_mouse_exited():
	inMouse = false


func _returnProperties():
	var truProperties = []
	
	for x in properties:
		truProperties.append([x[0] + beat,x[1]])
	
	return truProperties
