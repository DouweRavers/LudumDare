class_name CameraController extends Camera3D

@export var smoothness:float = 10;

@onready var player:Node3D = $".."
@onready var drone:Node3D = player.get_node("Drone")
@onready var drone_target_pivot:Node3D = drone.get_node("TargetPivot")
@onready var drone_target:Node3D = drone_target_pivot.get_node("CameraTarget")

func _process(delta)->void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		drone_target_pivot.rotation.y -= Input.get_last_mouse_velocity().normalized().x * delta * PI
	else:
		drone_target_pivot.rotation.y = lerp(drone_target_pivot.rotation.y, 0.0, delta)
	var target_pos:Vector3 = drone_target.global_position
	target_pos.y = drone.position.y+drone_target.position.y
	position = lerp(position, target_pos, delta*smoothness)
	look_at(drone.position)
