class_name Storage extends RefCounted

var capacity_storage:int
var container:Array

func _init(capacity:int, content:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]):
	capacity_storage = capacity
	container = content

func add_item_to_storage(type:int, value:int)->bool:
	if container.size() > type:
		if capacity_storage <= get_content_size(): return false
		container[type] += value
	else:
		for i in range(type+1-container.size()): container.push_back(0) 
		container[type] = value
	return true

func get_content_size()->int: return container.reduce(func(a:int,b:int): return a+b)

func transfer_contents(storage:Storage, type:int = -1)->void:
	if type != -1:
		container[type] += storage.container[type]
		storage.container[type] = 0
	else: 
		for i in range(container.size()):
			container[i] += storage.container[i]
			storage.container[i] = 0
