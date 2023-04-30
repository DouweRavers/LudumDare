class_name PlayerController extends Node3D

var storage:Storage = Storage.new(5)

func add_item(item_type:int)->bool: return storage.add_item_to_storage(item_type, 1)
