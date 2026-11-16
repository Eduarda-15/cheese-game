extends Node2D

@onready var titulo: Label = $Label
@onready var botao_proxima: Button = $ProximaFase
@onready var botao_reiniciar: Button = $Reiniciar
@onready var botao_sair: Button = $Sair


func _ready() -> void:
	# Sem próxima fase = o jogador zerou o jogo
	if Estado.proxima_fase == "":
		titulo.text = "Você venceu o jogo!!"
		botao_proxima.visible = false
		# Sobe os outros botões para ocupar o lugar do "Próxima fase"
		botao_reiniciar.position.y = botao_proxima.position.y
		botao_sair.position.y = botao_reiniciar.position.y + 61


func _on_proxima_fase_pressed() -> void:
	get_tree().change_scene_to_file(Estado.proxima_fase)


func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file(Estado.cena_atual)
