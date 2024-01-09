extends Camera3D

var player
var camera1
var camera2
var camera3

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../player")
	camera1 = get_node("../camera1")
	camera2 = get_node("../camera2")
	camera3 = get_node("../camera3")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera1.look_at((player.position)+Vector3.UP, Vector3.UP)
	camera2.look_at((player.position)+Vector3.UP, Vector3.UP)
	camera3.look_at((player.position)+Vector3.UP, Vector3.UP)
