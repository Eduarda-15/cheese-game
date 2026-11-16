extends Node
# Autoload "Estado": guarda informações que precisam sobreviver à troca de cena.

# Fase que está sendo jogada (para "Reiniciar" voltar para a fase certa)
var cena_atual: String = "res://cenas/jogo.tscn"
# Próxima fase depois de vencer (vazio = era a última fase)
var proxima_fase: String = ""
# Motivo mostrado na tela de derrota
var motivo_derrota: String = ""
