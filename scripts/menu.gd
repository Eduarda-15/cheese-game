extends Control


# Sinal "pressed" do botão Jogar (conectado em menu.tscn)
func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/jogo.tscn")
