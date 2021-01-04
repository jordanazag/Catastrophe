extends CanvasLayer
# este dira al nodo main que se ha presionado un boton
signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

# esta funcion es llamada cuando el jugador pierde
func show_game_over():
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "EVITA QUE TE RAJEN!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
	
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
func update_score(score):
	$ScoreLabel.text = str(score) #transforma variables de cualquier tipo a texto 
