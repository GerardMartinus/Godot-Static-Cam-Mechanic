extends CharacterBody3D
 
# Variaveis de movimentação
@export_category("Movement Settings")
@export var FORWARD_SPEED = 5.0
@export var BACK_SPEED = 5.0
@export var TURN_SPEED = 0.06

var camera
var camera2
var camera3
var current_camera

var Vec3Z = Vector3.ZERO

func _ready():
	camera = get_node("../camera")
	camera2 = get_node("../camera2")
	camera3 = get_node("../camera3")

#OPTIONAL: These could be used to change sensitivity of either rotating z or y
#var M_LOOK_SENS = 1
#var V_LOOK_SENS = 1

# Movimentação tipo tanque
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.z = 0

	elif Input.is_action_pressed("ui_up"):
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -forwardVector * FORWARD_SPEED
		
	elif Input.is_action_pressed("ui_down"):
		var backwardVector = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = -backwardVector * BACK_SPEED
	
	#If pressing nothing stop velocity
	else:
		velocity.x = 0
		velocity.z = 0
	
	# IF turn left WHILE moving back, turn right
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"):
		rotation.z -= Vec3Z.y + TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED #* M_LOOK_SENS
	
	elif Input.is_action_pressed("ui_left"):
		rotation.z += Vec3Z.y - TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED #* M_LOOK_SENS

	# IF turn right WHILE moving back, turn left
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
		rotation.z += Vec3Z.y - TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED #* M_LOOK_SENS
		
	elif Input.is_action_pressed("ui_right"):
		rotation.z -= Vec3Z.y + TURN_SPEED #* V_LOOK_SENS
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED #* M_LOOK_SENS
	
	move_and_slide()

func _change_camera(currentCamera, lastCamera):
	currentCamera.set_current(true)
	lastCamera.set_current(false)

func _compare_camera_trigger():
	var current_camera_trigger_number = current_camera[-1]
	print(current_camera_trigger_number)
	
func _get_current_camera(current_camera):
	current_camera = current_camera
	print('string: ', current_camera.get_meta_list())
	print(str(current_camera))

func _on_trigger_cam_1_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_change_camera(camera, camera2)
	_get_current_camera(camera)
	
func _on_trigger_cam_1_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	_change_camera(camera2, camera)
	
func _on_trigger_cam_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_change_camera(camera2, camera)
	_get_current_camera(camera2)

func _on_trigger_cam_2_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	_change_camera(camera, camera2)

func _on_trigger_cam_3_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_change_camera(camera3, camera)

func _on_trigger_cam_3_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	_change_camera(camera, camera3)
