class_name MainMenu extends TextureRect

func _ready():
	for i in range(1,1+$VBoxContainer/GridContainer.get_child_count()-1):
		var button:Button = get_node("VBoxContainer/GridContainer/Button"+str(i))
		button.disabled =  SceneController.unlocked_level < i

func _process(delta):
	var tex :GradientTexture1D = texture as GradientTexture1D
	var color:Color=tex.gradient.get_color(0)
	color.h += delta/50
	tex.gradient.set_color(0, color)
	color=tex.gradient.get_color(1)
	color.h += delta/50
	tex.gradient.set_color(1, color)

func _on_level_play(level:int):
	get_tree().get_root().add_child(load("res://Scenes/level"+str(level)+".tscn").instantiate())
	queue_free()
