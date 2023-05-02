class_name MultiFactory extends Interactable

# temp for quick dev -> generalize and make inherit from Factory
var input_types:PackedInt32Array=[ 
	Constants.FLOWER,						# common
	Constants.BUCKET_WATER, 				# bread
	Constants.TOMATO, 						# pizza
	Constants.EGGS, Constants.BUCKET_MILK	# pancake
	]

@export var bread:PackedScene
@export var pizza:PackedScene
@export var pancakes:PackedScene

var storage:Storage = Storage.new(100)

func _ready():
	super._ready()
	$Timer.connect("timeout", _on_timer_timeout)

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	var has_transfered_items:bool=false
	for input_type in input_types:
		if 0 < player.storage.container[input_type]:
			storage.transfer_contents(player.storage, input_type)
			has_transfered_items=true
	if has_transfered_items:
		$PressedIndicator.restart()
		$PositiveAudio.play()
	else:
		$NegativeAudio.play()

func _on_timer_timeout():
	# pancakes
	if 0 < storage.container[Constants.FLOWER] \
	and 0 < storage.container[Constants.BUCKET_MILK] \
	and 0 < storage.container[Constants.EGGS]:
		storage.container[Constants.FLOWER]-=1
		storage.container[Constants.BUCKET_MILK]-=1
		storage.container[Constants.EGGS]-=1
		storage.container[Constants.PANCAKE]+=1
	# pizza
	elif 0 < storage.container[Constants.FLOWER] \
	and 0 < storage.container[Constants.TOMATO]:
		storage.container[Constants.FLOWER]-=1
		storage.container[Constants.TOMATO]-=1
		storage.container[Constants.PIZZA]+=1
	# bread
	elif 0 < storage.container[Constants.FLOWER] \
	and 0 < storage.container[Constants.BUCKET_WATER]:
		storage.container[Constants.FLOWER]-=1
		storage.container[Constants.BUCKET_WATER]-=1
		storage.container[Constants.BREAD]+=1
	
	for i in range($SpawnPoints.get_child_count()):
		var node:Node = get_node("SpawnPoints/pos"+str(i+1))
		if 0 != storage.container[Constants.PANCAKE]:
			node.add_child(pancakes.instantiate())
			storage.container[Constants.PANCAKE]-=1
		
		elif 0 != storage.container[Constants.PIZZA]:
			node.add_child(pizza.instantiate())
			storage.container[Constants.PIZZA]-=1
		
		elif 0==node.get_child_count():
			if 0 != storage.container[Constants.BREAD]:
				node.add_child(bread.instantiate())
				storage.container[Constants.BREAD]-=1
