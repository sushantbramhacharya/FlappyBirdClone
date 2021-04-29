extends Node2D

signal obstacle_created(obs)

onready var timer=$Timer

var Obstacle = preload("res://Environment/pipes.tscn")

func _ready():
	randomize()
func _on_Timer_timeout():
	spawn_obs()
	
func spawn_obs():
	var obstacle=Obstacle.instance()
	add_child(obstacle)
	obstacle.position.x=50
	obstacle.position.y=randi()%400+150
	emit_signal("obstacle_created",obstacle)
		

func start():
	timer.start()
	
func stop():
	timer.stop()



