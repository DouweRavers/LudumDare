class_name Pickable extends Interactable

@export var type:int = Constants.APPLE

func _ready():
	super._ready()
	$AnimationPlayer.connect("animation_finished", _on_animation_player_animation_finished)

func _on_animation_player_animation_finished(_anim_name):
	queue_free()

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	if player.storage.add_item_to_storage(type, 1):
		$PressedIndicator.restart()
		$AnimationPlayer.play("Remove")
		$PositiveAudio.play()
	else:
		$NegativeAudio.play()
