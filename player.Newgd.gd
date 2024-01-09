extends CharacterBody3D
 
# Variaveis de movimentação
@export_category("Movement Settings")
@export var FORWARD_SPEED = 5.0
@export var BACK_SPEED = 5.0
@export var TURN_SPEED = 0.06

var Vec3Z = Vector3.ZERO

func _ready():
	for camTrigger in get_tree().get_nodes_in_group("camTrigger"):
		camTrigger.connect("body_entered", 
		func(body):
			var Trigger = camTrigger.name.right(1)
			for cameras in get_tree().get_nodes_in_group("cameras"):
				var Camera = cameras.name.right(1)
				if Trigger == Camera:
					cameras.set_current(true))
					
#OPTIONAL: These could be used to change sensitivity of either rotating z or y
#var M_LOOK_SENS = 1
#var V_LOOK_SENS = 1

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
