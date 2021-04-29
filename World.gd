extends Node2D

onready var hud=$HUD
onready var obs_spwanner=$ObstacleSpanner
onready var ground=$GROUND
onready var menu_layer=$MenuLayer

const SAVE_FILE_PATH="user://savedata.save"

var score = 0  setget set_score
var highscore=0

func _ready():
	obs_spwanner.connect("obstacle_created",self,"_on_obstacle_created")
	load_highscore()
	$swoosh.play()
	
func newGame():
	
	self.score=0
	obs_spwanner.start()

func player_score():
	print("FUNC player_score RUNNNED !!!")
	self.score += 1
	print(self.score)
	

func set_score(new_score):
	score=new_score
	hud.update_score(score)

func _on_obstacle_created(obs):
	print("obs siginal recived")
	obs.connect("score",self,"player_score")


func _on_DeathZone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_Player_died():
	game_over()


func game_over():
	obs_spwanner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles","set_physics_process",false)
	menu_layer.init_game_over_menu(score,highscore)
	
	if score>highscore:
		highscore=score
		save_highscore()


func _on_MenuLayer_start_game():
	newGame()

func save_highscore():
	var save_data=File.new()
	save_data.open(SAVE_FILE_PATH,File.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var save_data=File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH,File.READ)
		highscore=save_data.get_var()
		save_data.close()
