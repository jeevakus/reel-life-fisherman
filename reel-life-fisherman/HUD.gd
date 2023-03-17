extends CanvasLayer

signal start_game
var score_count = 0

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
func _on_MessageTimer_timeout():
	$Message.hide()
	
func _on_Main_score():
	score_count += 1
	$ScoreLabel.text = str(score_count)
