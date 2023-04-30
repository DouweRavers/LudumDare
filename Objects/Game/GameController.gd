class_name GameController extends Node3D

var requested:Storage = Storage.new(100, [1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1])
var delivered:Storage = Storage.new(100)

func _process(_delta):
	var difference:int = 0
	for i in range(requested.container.size()):
		difference += clamp(requested.container[i] - delivered.container[i], 0, 100)
	if(difference == 0):
		print("Level done!")


