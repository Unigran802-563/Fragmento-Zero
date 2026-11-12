extends Node2D

const RETRATO_3: Texture2D = preload("res://sprites/astronauta/rosto/3vidas.png")
const RETRATO_2: Texture2D = preload("res://sprites/astronauta/rosto/2vidas.png")
const RETRATO_1: Texture2D = preload("res://sprites/astronauta/rosto/1vida.png")
const RETRATO_MORTE: Texture2D = preload("res://sprites/astronauta/rosto/morte.png")

const CORACAO_3: Texture2D = preload("res://sprites/vidas/3vidas.png")
const CORACAO_2: Texture2D = preload("res://sprites/vidas/2vidas.png")
const CORACAO_1: Texture2D = preload("res://sprites/vidas/1vida.png")
const CORACAO_VAZIO: Texture2D = preload("res://sprites/vidas/morte.png")

@onready var tempo: Timer = $Tempo
@onready var texto_tempo: Label = $HUD/TextoTempo
@onready var astronauta = $Astronauta
@onready var retrato_vida: TextureRect = $HUD/RetratoVida
@onready var icone_vida: TextureRect = $HUD/IconeVida



func _process(_delta: float) -> void:
	texto_tempo.text = "Tempo: %d" % ceil(tempo.time_left)

	if astronauta.vida <= 0:
		retrato_vida.texture = RETRATO_MORTE
	elif astronauta.vida == 1:
		retrato_vida.texture = RETRATO_1
	elif astronauta.vida == 2:
		retrato_vida.texture = RETRATO_2
	else:
		retrato_vida.texture = RETRATO_3

	if astronauta.vida <= 0:
		icone_vida.texture = CORACAO_VAZIO
	elif astronauta.vida == 1:
		icone_vida.texture = CORACAO_1
	elif astronauta.vida == 2:
		icone_vida.texture = CORACAO_2
	else:
		icone_vida.texture = CORACAO_3




func _on_tempo_timeout() -> void:
	print("60 segundos: a saída pode abrir.")
