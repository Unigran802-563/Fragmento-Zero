extends Node2D

# Origem: trechos sugeridos por IA (Manus), adaptados aos recursos do projeto.
const RETRATO_3: Texture2D = preload("res://sprites/astronauta/rosto/3vidas.png")
const RETRATO_2: Texture2D = preload("res://sprites/astronauta/rosto/2vidas.png")
const RETRATO_1: Texture2D = preload("res://sprites/astronauta/rosto/1vida.png")
const RETRATO_MORTE: Texture2D = preload("res://sprites/astronauta/rosto/morte.png")

const CORACAO_3: Texture2D = preload("res://sprites/vidas/3vidas.png")
const CORACAO_2: Texture2D = preload("res://sprites/vidas/2vidas.png")
const CORACAO_1: Texture2D = preload("res://sprites/vidas/1vida.png")
const CORACAO_VAZIO: Texture2D = preload("res://sprites/vidas/morte.png")

@onready var saida: Area2D = $Saida
@onready var tela_vitoria: Control = $HUD/TelaVitoria
@export var cena_asteroide: PackedScene
@onready var tela_derrota: Control = $HUD/TelaDerrota
@onready var camera: Camera2D = $CameraJogador
@onready var tempo: Timer = $Tempo
@onready var horda: Timer = $Horda
@onready var astronauta = $Astronauta
@onready var nascedouros: Node2D = $Nascedouros
@onready var texto_tempo: Label = $HUD/TextoTempo
@onready var retrato_vida: TextureRect = $HUD/RetratoVida
@onready var icone_vida: TextureRect = $HUD/IconeVida


func _process(_delta: float) -> void:
	texto_tempo.text = "Tempo: %d" % ceil(tempo.time_left)

	if astronauta.vida <= 0:
		retrato_vida.texture = RETRATO_MORTE
		icone_vida.texture = CORACAO_VAZIO
	elif astronauta.vida == 1:
		retrato_vida.texture = RETRATO_1
		icone_vida.texture = CORACAO_1
	elif astronauta.vida == 2:
		retrato_vida.texture = RETRATO_2
		icone_vida.texture = CORACAO_2
	else:
		retrato_vida.texture = RETRATO_3
		icone_vida.texture = CORACAO_3


func _on_tempo_timeout() -> void:
	saida.visible = true
	saida.monitoring = true



func _on_horda_timeout() -> void:
	var pontos_disponiveis = nascedouros.get_children()
	if pontos_disponiveis.is_empty():
		return

	var quantidade := 1
	if randf() < 0.25:
		quantidade = 3
		print("Rajada de asteroides!")

	# Origem: trecho sugerido por IA (Manus), adaptado à horda do projeto.
	var id_rajada := str(Time.get_ticks_usec())
	var segundos_jogados: float = tempo.wait_time - tempo.time_left
	var multiplicador: float = 1.0 + clampf(segundos_jogados / 60.0, 0.0, 1.0)

	for _i in range(quantidade):
		if pontos_disponiveis.is_empty():
			break

		var ponto = pontos_disponiveis.pick_random()
		pontos_disponiveis.erase(ponto)

		var asteroide = cena_asteroide.instantiate()
		asteroide.velocidade *= multiplicador

		if quantidade > 1:
			asteroide.set_meta("id_rajada", id_rajada)

		add_child(asteroide)
		asteroide.global_position = ponto.global_position
		asteroide.direcao = asteroide.global_position.direction_to(
			astronauta.global_position
		)
		
		# Origem: lógica sugerida por IA (Manus), adaptada ao projeto.
func mostrar_derrota() -> void:
	tela_derrota.visible = true
	get_tree().paused = true
	
	
# Origem: lógica sugerida por IA (Manus), adaptada ao projeto.
func tremer_camera() -> void:
	var tween := create_tween()
	for _i in range(6):
		camera.offset = Vector2(
			randf_range(-6.0, 6.0),
			randf_range(-4.0, 4.0)
		)
		await get_tree().create_timer(0.03).timeout
	camera.offset = Vector2.ZERO


# Origem: lógica sugerida por IA (Manus), adaptada ao projeto.
func _on_saida_body_entered(body: Node2D) -> void:
	if body == astronauta:
		tela_vitoria.visible = true
		get_tree().paused = true
