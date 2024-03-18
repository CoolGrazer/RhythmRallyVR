extends Node2D

@export var deafaultLength : int = 2
@export var properties = [[0,"serve"]]

var beat = 0

@onready var button = get_node("Origin/Button")
@onready var label = get_node("Origin/Button/Label")

var selected : bool = false


var inMouse : bool = false

var offset : Vector2 = Vector2.ZERO
var ogPosition : Vector2 = Vector2.ZERO
var ogMouse : Vector2 = Vector2.ZERO

func _ready():
	button.size.x = deafaultLength * 50
	selected = true
	

func _physics_process(delta):
	beat = global_position / 50
	
	
	label.custom_minimum_size.x = button.size.x - 10
	
	if selected == true:
		offset.x = snapped(get_global_mouse_position().x - ogMouse.x,50/2)
		offset.y = snapped(get_global_mouse_position().y - ogMouse.y,40)
		
		global_position = ogPosition + offset
		
	
	
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
