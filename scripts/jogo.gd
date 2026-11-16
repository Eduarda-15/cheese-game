extends Node2D

# Vidas do rato
@export var vidas: int = 3
@export var vidas_maximas: int = 5

# Configuração da fase
@export var numero_fase: int = 1
# Cena da próxima fase (vazio = última fase)
@export_file("*.tscn") var proxima_fase: String = ""
# Tempo limite em segundos (0 = sem limite de tempo)
@export var tempo_limite: float = 0.0

var tempo_restante: float = 0.0
var terminou: bool = false # evita vitória/derrota duas vezes

@onready var rato = $Rato
@onready var label_vidas: Label = $CanvasLayer/LabelVidas
@onready var label_tempo: Label = $CanvasLayer/LabelTempo


func _ready():
	Estado.cena_atual = scene_file_path
	tempo_restante = tempo_limite
	label_tempo.visible = tempo_limite > 0.0
	atualizar_ui()
	atualizar_tempo_ui()
	print("Cheese-Escape fase ", numero_fase, " iniciada! Vidas: ", vidas)


# Cronômetro regressivo (só roda se a fase tiver tempo limite; pausa junto com o jogo)
func _process(delta):
	if tempo_limite <= 0.0 or terminou:
		return

	tempo_restante = maxf(tempo_restante - delta, 0.0)
	atualizar_tempo_ui()

	if tempo_restante <= 0.0:
		derrota("O tempo acabou!")


func atualizar_tempo_ui():
	label_tempo.text = "Tempo: " + str(ceili(tempo_restante))
	# Fica vermelho nos últimos 10 segundos
	if tempo_restante <= 10.0:
		label_tempo.add_theme_color_override("font_color", Color.RED)
	else:
		label_tempo.add_theme_color_override("font_color", Color.WHITE)


# Atualiza o texto da label que mostra as vidas na tela
func atualizar_ui():
	label_vidas.text = "Vidas: " + str(vidas)


# Chamada pela ratoeira e pelo gato quando o rato é atingido
func perder_vida(motivo: String = ""):
	if terminou:
		return
	vidas -= 1
	atualizar_ui()
	print(motivo, " Vidas restantes: ", vidas)

	if vidas <= 0:
		derrota("Perdeu todas as vidas!")
		return

	piscar_rato(Color.RED)


# Chamada pela migalha quando o rato come
func ganhar_vida():
	if vidas < vidas_maximas:
		vidas += 1
	atualizar_ui()
	print("Migalha coletada! Vidas: ", vidas)
	piscar_rato(Color.GREEN)


# Deixa o rato de outra cor por um instante (feedback visual)
func piscar_rato(cor: Color):
	rato.modulate = cor
	await get_tree().create_timer(0.2).timeout
	rato.modulate = Color.WHITE


# Chamada pelo queijo
func vitoria():
	if terminou:
		return
	terminou = true
	print("VITÓRIA! Comeu o queijo!")
	Estado.proxima_fase = proxima_fase
	get_tree().change_scene_to_file("res://cenas/vitoria.tscn")


func derrota(motivo: String):
	if terminou:
		return
	terminou = true
	print("DERROTA: ", motivo)
	Estado.motivo_derrota = motivo
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/derrota.tscn")


# Essa função vai ser chamada pela Ratoeira pra aumentar dificuldade
func _on_timer_spawn_timeout():
	var nova = preload("res://cenas/ratoeira.tscn").instantiate()
	# Pega uma posição aleatória no labirinto
	nova.global_position = Vector2(randf_range(100, 600), randf_range(100, 500))
	add_child(nova)
