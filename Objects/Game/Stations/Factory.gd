class_name Factory extends Interactable

@export var input_item_type:int #PickableItem
@export var output_item_type:int #PickableItem
@export var output_item_path:PackedScene

var storage:Storage = Storage.new(100)

func _ready():
	super._ready()
	$Timer.connect("timeout", _on_timer_timeout)

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	if 0 < player.storage.container[input_item_type]:
		storage.transfer_contents(player.storage, input_item_type)
		$PressedIndicator.restart()
		$PositiveAudio.play()
	else:
		$NegativeAudio.play()

func _on_timer_timeout():
	if 0 < storage.container[input_item_type]:
		storage.container[input_item_type]-=1
		storage.container[output_item_type]+=1
	
	for i in range($SpawnPoints.get_child_count()):
		if 0 == storage.container[output_item_type]: break
		var node:Node = get_node("SpawnPoints/pos"+str(i+1))
		if 0==node.get_child_count():
			node.add_child(output_item_path.instantiate())
			storage.container[output_item_type]-=1
