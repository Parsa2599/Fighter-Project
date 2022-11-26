extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed = 0
var tiltspeed = 1
var rotspeed = 1
var tilt = 0
var rollspeed = 0.3
var gravity = -10
var acc = 8
var accdecay = 2
var am_speed = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.translate(Vector3(0,0,speed*delta))
	if speed < 0:
		speed = 0
	#self.translate(Vector3(0,delta*gravity,0))
	var pitch = self.rotation
	self.global_rotate(Vector3(0,1,0),rotspeed*delta*-pitch.z)
	if Input.is_action_pressed("ui_up"):
		speed = speed+delta*acc
	else:
		speed = speed-delta*accdecay
	if Input.is_action_pressed("ui_down"):
		speed = speed-delta*acc
	if Input.is_action_pressed("ui_accept"):
		rotate_object_local(Vector3(1,0,0),rollspeed*delta)
	if Input.is_action_pressed("ui_cancel"):
		rotate_object_local(Vector3(1,0,0),-rollspeed*delta)
	if Input.is_action_pressed("ui_right"):
		rotate_object_local(Vector3(0,0,1),tiltspeed*delta)
		tilt = tilt+tiltspeed*delta
	if Input.is_action_pressed("ui_left"):
		rotate_object_local(Vector3(0,0,1),-tiltspeed*delta)
		tilt = tilt-tiltspeed*delta
	if not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		if tilt > 0: 
			tilt = tilt-delta*accdecay
		else:
			tilt = tilt+delta*accdecay
	var label = get_node("../Angle")
	label.text="Angle:"+str(180*tilt/3.14)
	var labelS = get_node("../Speed")
	labelS.text="Speed:"+str(speed)
	#Add Gryoscope
	#Missile can be launched
	if Input.is_action_pressed("ui_select"):
		var m = get_node("./missile_air_to_air")
		if m: 
			self.remove_child (m)
			get_node("..").add_child(m)
	#Fix angle issue
