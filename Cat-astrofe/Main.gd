extends Node
export (PackedScene) var Mob
var score
func _ready():
	randomize()
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()
func _on_HUD_start_game():
	$HUD.update_score(score)
	$HUD.show_message("PREPARADO!")
func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi()) #selecciona una posicion random para el enemigo
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	$HUD.connect("start_game", mob, "_on_start_game")
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
# temporizadores
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
	
