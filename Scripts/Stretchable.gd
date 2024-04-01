extends Node2D

@export var length : float = 5
@export var properties = [[0,"serve"],[0.5,"me"]]
@export var text = "Serve"

var beat = 0

@onready var button = get_node("Origin/Button")
@onready var label = get_node("Origin/Button/Label")

var selected : bool = false

var adjText : String = ""

var inMouse : bool = false

var offset : Vector2 = Vector2.ZERO
var ogPosition : Vector2 = Vector2(176,0)
var ogMouse : Vector2
var firstAnim : bool = true

var target : Vector2 = Vector2.ZERO
var canDelete : bool = true

var edgeHovered : bool = false
var edgeSelected : bool = false
var oldLength : float = length


func _ready():
	adjText = text + " "
	button.size.x = length * 50
	$Origin/Button.grab_focus()
	var subPos = get_global_mouse_position().x - 177
	subPos = snapped(subPos,27)
	global_position.x = subPos + 177
	selected = true
	
	
	
	# my blocks won't work anymore :(
	


func _physics_process(delta):
	_mouseInBox()
	if position == Vector2(0,24):
		hide()
	else:
		show()
	button.size.x = length * 54
	adjText = text + " "
	if Input.is_action_just_pressed("Delete") and canDelete == true:
		$AnimationPlayer.play("Delete")
	
	$Origin/Button/Label.text = adjText
	
	beat = ((global_position.x - 177) / 54)
	
	
	
	
	label.size.x = button.size.x
	label.position.x = 0
	
	
	if firstAnim == true:
		#global_position.x = get_global_mouse_position().x
		ogMouse = get_global_mouse_position()
		ogPosition = global_position
		
		$Origin/Button.grab_focus()
	
	if selected == true and firstAnim == false:
		offset.x = snapped(get_global_mouse_position().x - ogMouse.x,54/2)
		offset.y = snapped(get_global_mouse_position().y - ogMouse.y,40)
		
		
		
		global_position = ogPosition + offset
		
	
	if $AnimationPlayer.current_animation == "":
		firstAnim = false
	
	
	if inMouse == true and Input.is_action_just_pressed("Click") and edgeHovered == false:
		ogPosition = global_position
		ogMouse = get_global_mouse_position()
		selected = true
		canDelete = true
		show()
		
	
	if Input.is_action_just_released("Click") and (selected == true):
		selected = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
	if Input.is_action_just_released("Click") and (edgeSelected == true):
		edgeSelected = false
		Input.set_default_cursor_shape(Input.CURSOR_HSIZE)
	
	if edgeHovered == true and Input.is_action_just_pressed("Click"):
		edgeSelected = true
		oldLength = length
		ogMouse.x = get_global_mouse_position().x
	
	if edgeSelected == true:
		length = oldLength + (snapped((get_global_mouse_position().x - ogMouse.x),54/2) / 54)
	
	position.x = clamp(position.x,177,10000000)
	position.y = clamp(position.y,464,584)
	$Origin/Area2D/CollisionShape2D.position.x = ((length - 1) * 54) + 40
	
	# Figure out how to do the beat var good.


func _on_button_mouse_entered():
	inMouse = true


func _on_button_mouse_exited():
	inMouse = false


func _returnProperties():
	var truProperties = []
	
	for x in properties:
		if x.size() == 2:
			truProperties.append([x[0] + beat,x[1],length])
		elif x.size() == 3:
			truProperties.append([x[0] + beat,x[1],x[2],length])
		elif x.size() == 4:
			truProperties.append([x[0] + beat,x[1],x[2],x[3],length])
	
	return truProperties




func _mouseInBox():
	if checkX() and checkY():
		edgeHovered = true
	else:
		edgeHovered = false

func checkX():
	return get_global_mouse_position().x < (global_position.x + $Origin/Area2D/CollisionShape2D.position.x + 10) and get_global_mouse_position().x + 0 > (global_position.x + $Origin/Area2D/CollisionShape2D.position.x - 10)

func checkY():
	return get_global_mouse_position().y < (global_position.y + $Origin/Area2D/CollisionShape2D.position.y  + 19.5)and get_global_mouse_position().y + 0 > (global_position.y + $Origin/Area2D/CollisionShape2D.position.y - 19.5)
