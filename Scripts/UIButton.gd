extends Button

@export var property = ""
var selected : bool = false

func _process(delta):
	if is_hovered() or has_focus():
		modulate = Color.AQUA
	else:
		modulate = Color.WHITE
		selected = false
	
	if has_focus():
		selected = true
	else:
		selected = false

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		if is_hovered() == false:
			mouse_filter = Control.MOUSE_FILTER_IGNORE
	elif event is InputEventMouseButton and event.is_released() and event.button_index == 1:
		
		mouse_filter = Control.MOUSE_FILTER_STOP

func _findSelected():
	if selected == false:
		return
	else:
		get_parent().get_parent().get_parent().selected = property
