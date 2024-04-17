extends Label

var sliderVal = 0.0

func _process(delta):
	
	sliderVal = $HScrollBar.value
	$LineEdit.text = str(snapped(sliderVal,0.1))


func _on_line_edit_text_submitted(new_text):
	print(new_text)
	$HScrollBar.value = float(new_text)


func _on_line_edit_text_changed(new_text):
	print(new_text)
	$HScrollBar.value = float(new_text)

