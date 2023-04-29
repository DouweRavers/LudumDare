class_name GameController extends Node3D

var requested:Storage = Storage.new(100, [2,0])
var delivered:Storage = Storage.new(100)

func _process(delta):
	var difference:int = 0
	for i in range(requested.container.size()):
		difference += clamp(requested.container[i] - delivered.container[i], 0, 100)
	if(difference == 0):
		print("Level done!")


