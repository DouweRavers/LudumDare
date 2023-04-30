class_name Interactable extends CollisionObject3D

@export var picking_distance = 20

func _ready(): 
	$HoverIndicator.hide()

func _on_mouse_entered(): if in_distance(): $HoverIndicator.show()
func _on_mouse_exited(): $HoverIndicator.hide()

func _on_input_event(_camera, event, _position, _normal, _shape_idx)->void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed and in_distance():
		on_clicked()

func on_clicked(): pass

func in_distance()->bool:
	var drone = get_tree().get_root().get_node("Level/Player/Drone")
	return drone.global_position.distance_to(global_position) < picking_distance
