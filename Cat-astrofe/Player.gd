extends Area2D
signal hit # añade una señal para saber cuando el jugador es golpeado por un enemigo
export var speed = 400 # esta variable determinara que tan rapido se movera el personaje
var screen_size # tamaño de la ventana del juego
# funcion que comprueba el tamaño del juego cada que inicia
func _ready():
	screen_size = get_viewport_rect().size
	#hide() # oculta al personaje mientras el juego empieza
# funcion que asigna los movimientos del jugador "player"
func _process(delta):
	var velocity = Vector2() # es el vector de movimiento del jugador
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	# los siguientes comandos evitan que el jugador abandone la pantalla
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# añadimos el siguiente codigo para que los movimientos del player
	# empataran correctamente con la animacion que creamos
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false # gracias a esta linea no es necesario crear un sprite izq ya que este lo voltea verticalmente
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		if velocity.y < 0:
			$AnimatedSprite.animation = "up"
		elif velocity.y > 0:
			$AnimatedSprite.animation = "down"

# esta funcion se ejecuta cada ves que el player emite una señal de golpe
func _on_Player_body_entered(body):
	hide() # ocultamos a nuestro player al ser impactadp
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true) # deshabilitamos la señal hit para que una ves golpeado el player, no se siga emitiendo otro golpe "hit"

# esta funcion es llamada para realizar el reinicio del juego
func start(pos):
	show()
	position = pos
	$CollisionShape2D.disabled = false
	
	
	
