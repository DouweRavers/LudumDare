class_name Pickable extends CollisionObject3D

@export var type:int = Constants.APPLE
@export var picking_distance = 20
@export var tool:int = Constants.NO_TOOL

func _ready(): 
	$HoverIndicator.hide()

func _on_mouse_entered(): if in_distance(): $HoverIndicator.show()
func _on_mouse_exited(): $HoverIndicator.hide()

func _on_input_event(camera, event, position, normal, shape_idx)->void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed and in_distance():
		on_clicked()

func _on_animation_player_animation_finished(anim_name):
	queue_free()

func on_clicked():
	var player:PlayerController = get_tree().get_root().get_node("Level/Player")
	if player.has_tool(tool) and player.add_item(type):
		$PressedIndicator.restart()
		$AnimationPlayer.play("Remove")
	else:
		print("wrong tool or storage is full")


func in_distance()->bool:
	var drone = get_tree().get_root().get_node("Level/Player/Drone")
	return drone.global_position.distance_to(global_position) < picking_distance
