extends RigidBody2D
class_name Player
signal died

var alive = true

export var FLAP_FORCE=-300
const MAX_ROTATION_DEGREES=-30

onready var HIT=$HIT
onready var Wing=$WING
onready var animator=$AnimationPlayer

var started=false

func _physics_process(_delta):
	if Input.is_action_just_pressed("flap")&&alive:
		if !started:
		 start()
		flap()
	if rotation_degrees<=MAX_ROTATION_DEGREES:
		angular_velocity=0
		rotation_degrees=MAX_ROTATION_DEGREES
	if linear_velocity.y>0:
		if rotation_degrees<=90:
			angular_velocity=5
		else:
			angular_velocity=0
func start():
	if started: return
	started=true
	gravity_scale=10.0
	animator.play('Flap')
	
func flap():
	linear_velocity.y=FLAP_FORCE
	angular_velocity=-8.0
	Wing.play()
	
func die():
	if !alive: return
	alive=false
	emit_signal("died")
	animator.stop()
	HIT.play()
