extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed",self,'reset_plane')

func reset_plane():
	var plane = get_node("../F-2A")
	plane.global_transform.origin = Vector3(54,10,1)
	plane.speed = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
