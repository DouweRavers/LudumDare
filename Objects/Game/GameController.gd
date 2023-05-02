class_name GameController extends Node3D

@export var requirement:Dictionary={
	"1apples":0,
	"2tomatoes":0,
	"3wheat":0,
	"4eggs":0,
	"5bucket":0,
	"6milk":0,
	"7water":0,
	"8flower":0,
	"9 bread":0,
	"91pizza":0,
	"92pancake":0
}

@onready var requested:Storage = Storage.new(100, requirement.values())
@onready var delivered:Storage = Storage.new(100)

func _ready():
	delivered.connect("storage_changed", $"../UI"._on_game_deliveries_changed)

func _process(_delta):
	var difference:int = 0
	for i in range(requested.container.size()):
		difference += clamp(requested.container[i] - delivered.container[i], 0, 100)
	if(difference == 0): $"..".level_finished()

		


