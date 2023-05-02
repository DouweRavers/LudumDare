extends VBoxContainer

var index:int = 0

func _on_previous_button_down():
	if index == 0: return
	index -= 1
	$Slide.texture = load("res://Textures/Tutorial/Slide"+str(index+1)+".PNG")


func _on_next_button_down():
	if index == 7: return
	index += 1
	$Slide.texture = load("res://Textures/Tutorial/Slide"+str(index+1)+".PNG")
