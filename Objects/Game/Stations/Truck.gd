class_name DeliveryTruck extends Interactable

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	var game:GameController = get_tree().get_root().get_node("Level/Game")
	var size = game.delivered.get_content_size()
	game.delivered.transfer_contents(player.storage)
	if size == game.delivered.get_content_size():
		$NegativeAudio.play()
	else:
		$PressedIndicator.restart()
		$PositiveAudio.play()
