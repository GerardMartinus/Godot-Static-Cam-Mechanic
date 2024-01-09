extends Camera3D

var player
func _ready():
	player = get_node("../player")

func _process(delta):
	for camera in get_tree().get_nodes_in_group("cameras"):
		camera.look_at((player.position)+Vector3.UP, Vector3.UP)
	
