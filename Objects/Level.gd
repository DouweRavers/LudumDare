class_name Level extends Node3D

@export var level:int = 1

func level_finished():
	SceneController.unlocked_level = level+1
	get_tree().get_root().add_child(load("res://Scenes/MainMenu.tscn").instantiate())
	queue_free()
