extends Node2D

@onready var label_motivo: Label = $Motivo


func _ready() -> void:
	label_motivo.text = Estado.motivo_derrota


func _on_reiniciar_pressed() -> void:
	# Recomeça a fase em que o jogador perdeu
	get_tree().change_scene_to_file(Estado.cena_atual)


func _on_sair_pressed() -> void:
	get_tree().quit()
