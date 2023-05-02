class_name DroneController extends PhysicsBody3D

@export var toggle_stablizer:bool=true
@export var throttle_power:float=0.5
@export var steering_power:float=10

var input_vector:Vector4=Vector4.ZERO
var velocity:Vector3=Vector3.ZERO

func _input(_event)->void:
	input_vector.x = Input.get_axis("Forward", "Back")
	input_vector.y = Input.get_axis("ThrottleUp", "ThrottleDown")
	input_vector.z = Input.get_axis("TurnRight", "TurnLeft")
	input_vector.w = Input.get_axis("SideRight", "SideLeft")


func _process(delta)->void:
	# steering
	rotation_degrees.x = lerp(rotation_degrees.x, 30 * input_vector.x, delta*5)
	rotation_degrees.y += 90 * input_vector.z*delta
	rotation_degrees.z = lerp(rotation_degrees.z, 10 * input_vector.z, delta*5)
	rotation_degrees.z = lerp(rotation_degrees.z, 20 * input_vector.w, delta*5)
	
	# thrust
	var force = global_transform.basis.y
	force.y = -input_vector.y 
	velocity += force*throttle_power*delta
	if toggle_stablizer:
		velocity = lerp(velocity, Vector3.ZERO, delta)
	elif input_vector.y == 0:
		velocity.y = lerp(velocity.y, 0.0, delta)
	if 0.3<velocity.length(): velocity = velocity.normalized()*0.3
	var collision = move_and_collide(velocity)
	if collision != null:
		velocity = -velocity / 2
	
	# audio
	$AudioStreamPlayer3D.pitch_scale = 1+clamp(force.length(), 0, 0.5)
