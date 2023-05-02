class_name PlayerController extends Node3D

var storage:Storage = Storage.new(5)

func _ready():
	storage.connect("storage_changed", $"../UI"._on_player_storage_changed)
