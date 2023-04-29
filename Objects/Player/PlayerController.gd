class_name PlayerController extends Node3D

var tool:int= Constants.NO_TOOL
var storage:Storage = Storage.new(5)

func has_tool(tool_type:int)->bool: return tool_type == tool or tool_type == Constants.NO_TOOL
func add_item(item_type:int)->bool: return storage.add_item_to_storage(item_type, 1)
