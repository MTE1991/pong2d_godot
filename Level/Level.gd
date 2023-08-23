extends Node


var PlayerScore = 0
var OpponentScore = 0
var ball_speed = 600
var opponent_speed = 450
var opponent_diff = 45
var player_speed = 450


func _ready():
	get_tree().call_group('BallGroup', 'stop_ball')
	get_tree().call_group('PlayerGroup', 'stop_player')
	
	# Add Game Modes
	$GameModeBtn.add_item("Singleplayer")
	$GameModeBtn.add_item("Multiplayer")
	
	# Add difficulty options
	var difficulty = ["Easy", "Medium", "Hard"]
	for s in difficulty:
		$OptionButton.add_item(s)
	
	# Connect the start button with the timer
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")
	
	$CountdownLabel.visible = false
	$Credits.visible = false
	$GoBackButton.visible = false
	

func show_ui():
	$StartButton.show()
	$OptionButton.show()
	$GameModeBtn.show()
	$CreditsButton.show()
	$DifficultyLabel.show()
	$ExitButton.show()
	$CreditsButton.visible = true
	$CreditsButton/Label.visible = true

func hide_ui():
	$GoBackButton.hide()
	$Credits.hide()
	$StartButton.hide()
	$OptionButton.hide()
	$GameModeBtn.hide()
	$ExitButton.hide()
	$DifficultyLabel.hide()
	$GameTitle.hide()
	$AuthorTitle.hide()
	$CreditsButton.hide()
	$CreditsButton/Label.hide()


func _on_Left_body_entered(body):
	score_achieved()
	OpponentScore += 1


func _on_Right_body_entered(body):
	score_achieved()
	PlayerScore += 1


func _process(delta):
	$PlayerScore.text = str(PlayerScore)
	$OpponentScore.text = str(OpponentScore)
	$CountdownLabel.text = str(int($CountdownTimer.time_left) + 1)


func _on_CountdownTimer_timeout():
	get_tree().call_group('BallGroup','restart_ball', ball_speed)
	$Player.speed = player_speed
	$Opponent.speed = opponent_speed
	$Opponent.diff = opponent_diff
	$CountdownLabel.visible = false


func score_achieved():
	$Ball.position = Vector2(647, 360)
	get_tree().call_group('BallGroup','stop_ball')
	start_game()
	show_ui()
	$Player.position.y = 360
	$Opponent.position.y = 360


func start_game():
	$CountdownLabel.visible = false
	$ScoreSound.play()
	$Player.position.x = 50
	get_tree().call_group('PlayerGroup', 'start_player')
	$Opponent.position.x = 1280 - 50
	hide_ui()


func _on_StartButton_pressed():
	start_game()
	$CountdownTimer.start()
	$CountdownLabel.visible = true


func _on_OptionButton_item_selected(index):
	if $GameModeBtn.get_item_text(index) == "Singleplayer":
		if $OptionButton.get_item_text(index) == "Easy":
			ball_speed = 650
			opponent_speed = 450
			opponent_diff = 45
		elif $OptionButton.get_item_text(index) == "Medium":
			ball_speed = 750
			opponent_speed = 700
			player_speed = 650
			opponent_diff = 30
		else:
			ball_speed = 1000
			opponent_speed = 1000
			player_speed = 950
			opponent_diff = 25
			
	# Reset scores
	PlayerScore = 0
	OpponentScore = 0
	
	$PlayerScore.text = str(PlayerScore)
	$OpponentScore.text = str(OpponentScore)


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_CreditsButton_pressed():
	hide_ui()
	$GoBackButton.visible = true
	$Credits.visible = true


func _on_GoBackButton_pressed():
	show_ui()
	$GoBackButton.visible = false
	$Credits.visible = false


func _on_GameModeBtn_item_selected(index):
	if $GameModeBtn.get_item_text(index) == "Singleplayer":
		$Opponent.isHuman = false
	else:
		$Opponent.isHuman = true
		PlayerScore = 0
		OpponentScore = 0
		ball_speed = 700
