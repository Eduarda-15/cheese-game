extends CharacterBody2D

@export var velocidade: float = 150.0
# Quanto a velocidade aumenta a cada migalha comida
@export var bonus_migalha: float = 10.0
# Limite para o rato não ficar rápido demais
@export var velocidade_maxima: float = 190.0

@onready var animacao: AnimatedSprite2D = $"Animação"


func _physics_process(_delta):
	# Direção das setas do teclado (já vem normalizada)
	var direcao = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direcao * velocidade
	move_and_slide()

	# Anima só enquanto o jogador está apertando as setas
	if direcao != Vector2.ZERO:
		animacao.play("andando")
	else:
		animacao.play("parado")

	# O desenho do rato olha para a direita: espelha quando ele anda para a esquerda.
	# A zona morta evita ficar virando de lado ao andar quase na vertical.
	if direcao.x < -0.2:
		animacao.flip_h = true
	elif direcao.x > 0.2:
		animacao.flip_h = false


# Chamada pela migalha: deixa o rato um pouco mais rápido
func aumentar_velocidade():
	velocidade = minf(velocidade + bonus_migalha, velocidade_maxima)
