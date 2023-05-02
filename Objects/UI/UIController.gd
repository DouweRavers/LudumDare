class_name UIController extends Control

@onready var player:PlayerController = get_tree().get_root().get_node("Level/Player")
@onready var game:GameController = get_tree().get_root().get_node("Level/Game")

func _on_help_button_down(): $Tutorial.show()
func _on_close_button_down(): $Tutorial.hide()

func _ready():
	_on_player_storage_changed($"../Player".storage)
	_on_game_deliveries_changed($"../Game".delivered)

func _process(delta):
	$SpeedoMeetor/Adjustment/Label.text = "%d\nkm\\h" % ($"../Player/Drone".velocity.length() / delta * 3.6)

func _on_player_storage_changed(storage:Storage):
	for i in range(5): get_node("Panel/DroneStorage/Slot"+str(i+1)).texture = null
	var item_count = 1
	for i in range(storage.container.size()):
		if 0<storage.container[i]:
			var texture = load_texture(i)
			for j in range(storage.container[i]):
				get_node("Panel/DroneStorage/Slot"+str(item_count)).texture = texture
				item_count += 1

func _on_game_deliveries_changed(delivered:Storage):
	var requested:Storage = $"../Game".requested
	var item_count = 1
	for i in range(requested.container.size()):
		if 0<requested.container[i]:
			var texture = load_texture(i)
			for j in range(requested.container[i]):
				var node = get_node("Panel/OrderOverview/Slot"+str(item_count))
				node.texture = texture
				node.get_node("Label").text = "%d/%d" % [delivered.container[i],requested.container[i]]
			item_count += 1

func _on_stabilizer_toggled(button_pressed):
	$"../Player/Drone".toggle_stablizer = button_pressed
	var new_texture:Texture2D
	if button_pressed: new_texture = preload("res://Textures/UI/StabelizerOn.png")
	else: new_texture = preload("res://Textures/UI/StabelizerOff.png")
	$SpeedoMeetor/Adjustment/stabilizer.icon = new_texture

func load_texture(id:int)->Texture2D:
	match id:
		Constants.APPLE: return preload("res://Textures/icons/apple.png") as Texture2D
		Constants.TOMATO: return preload("res://Textures/icons/tomato.png") as Texture2D
		Constants.WHEAT: return preload("res://Textures/icons/wheat.png") as Texture2D
		Constants.EGGS: return preload("res://Textures/icons/egg.png") as Texture2D
		Constants.BUCKET: return preload("res://Textures/icons/bucket.png") as Texture2D
		Constants.BUCKET_MILK: return preload("res://Textures/icons/milk.png") as Texture2D
		Constants.BUCKET_WATER: return preload("res://Textures/icons/water.png") as Texture2D
		Constants.FLOWER: return preload("res://Textures/icons/flower.png") as Texture2D
		Constants.BREAD: return preload("res://Textures/icons/bread.png") as Texture2D
		Constants.PIZZA: return preload("res://Textures/icons/pizza.png") as Texture2D
		Constants.PANCAKE: return preload("res://Textures/icons/pancakes.png") as Texture2D
		_: return null

