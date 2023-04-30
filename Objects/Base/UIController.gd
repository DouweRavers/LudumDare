class_name UIController extends Control

@onready var player:PlayerController = get_tree().get_root().get_node("Level/Player")
@onready var game:GameController = get_tree().get_root().get_node("Level/Game")

@onready var drone_storage:BoxContainer = $DroneStorage/HBoxContainer/StorageOverview
@onready var truck_storage:BoxContainer = $TruckStorage/HBoxContainer/StorageOverview

func _process(_delta):
	drone_storage_display()
	truck_storage_display()

func drone_storage_display()->void:
	drone_storage.get_node("Apples/Label").text = str(player.storage.container[Constants.APPLE])
	drone_storage.get_node("Tomatos/Label").text = str(player.storage.container[Constants.TOMATO])
	drone_storage.get_node("../ProgressBar").value = player.storage.get_content_size()
	drone_storage.get_node("../ProgressBar").max_value = player.storage.capacity_storage

func truck_storage_display()->void:
	truck_storage.get_node("Apples/Label").text = "%d / %d" % [game.delivered.container[Constants.APPLE], game.requested.container[Constants.APPLE]]
	truck_storage.get_node("Tomatos/Label").text = "%d / %d" % [game.delivered.container[Constants.TOMATO], game.requested.container[Constants.TOMATO]]
	
	var difference:int = 0
	for i in range(game.requested.container.size()):
		difference += clamp(game.requested.container[i] - game.delivered.container[i], 0, 100)
	
	truck_storage.get_node("../ProgressBar").value = game.requested.get_content_size()-difference
	truck_storage.get_node("../ProgressBar").max_value = game.requested.get_content_size()
