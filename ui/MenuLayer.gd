extends CanvasLayer

signal start_game

onready var start_msg=$StartMenu/TextureRect/message
onready var tween=$Tween
onready var score_label=$GameOverMenu/OverMenu/Score
onready var high_score_label=$GameOverMenu/OverMenu/HighScore
onready var game_over_menu=$GameOverMenu/OverMenu

var game_started=false

func _input(event):
	if event.is_action_pressed("flap")&&!game_started:
		emit_signal("start_game")
		tween.interpolate_property(start_msg,"modulate:a",1,0,.5)
		tween.start()
		game_started=true

func init_game_over_menu(score,highscore):
	game_over_menu.visible=true
	high_score_label.text="BEST: "+str(highscore)
	score_label.text="SCORE: "+str(score)
	
	

func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
