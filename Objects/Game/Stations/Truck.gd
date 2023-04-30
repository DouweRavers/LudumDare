class_name DeliveryTruck extends Interactable

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	var game:GameController = get_tree().get_root().get_node("Level/Game")
	game.delivered.transfer_contents(player.storage)
	$PressedIndicator.restart()
