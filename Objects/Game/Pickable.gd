class_name Pickable extends Interactable

@export var type:int = Constants.APPLE

func _on_animation_player_animation_finished(_anim_name):
	queue_free()

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	if player.add_item(type):
		$PressedIndicator.restart()
		$AnimationPlayer.play("Remove")
	else:
		print("Storage is full")
