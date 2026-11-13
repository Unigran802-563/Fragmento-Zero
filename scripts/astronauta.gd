extends CharacterBody2D

# Movimento: referência à documentação oficial da Godot — CharacterBody2D e Input.get_vector().
# Troca das texturas: trecho sugerido por IA (Manus), adaptado para os sprites do projeto.

@export var velocidade: float = 220.0

const TEXTURA_FRENTE: Texture2D = preload("res://sprites/astronauta/frente.png")
const TEXTURA_COSTA: Texture2D = preload("res://sprites/astronauta/costa.png")
const TEXTURA_DIREITA: Texture2D = preload("res://sprites/astronauta/direita.png")
const TEXTURA_ESQUERDA: Texture2D = preload("res://sprites/astronauta/esquerda.png")

@export var vida: int = 3
var invulneravel := false

@onready var hurtbox: Area2D = $Hurtbox

@onready var sprite: Sprite2D = $Sprite2D
func _process(_delta: float) -> void:
	if vida > 0 and not invulneravel and hurtbox.has_overlapping_bodies():
		levar_dano()


func levar_dano() -> void:
	vida -= 1
	print("Vida restante: ", vida)

	if vida <= 0:
		# Origem: integração sugerida por IA (Manus), adaptada ao projeto.
		get_tree().change_scene_to_file("res://scenes/derrota.tscn")
		return

	invulneravel = true
	modulate.a = 0.4
	await get_tree().create_timer(1.0).timeout
	modulate.a = 1.0
	invulneravel = false



func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector(
		"mover_esquerda",
		"mover_direita",
		"mover_cima",
		"mover_baixo"
	)
	velocity = direcao * velocidade
	move_and_slide()

	if direcao != Vector2.ZERO:
		if abs(direcao.x) > abs(direcao.y):
			sprite.texture = TEXTURA_DIREITA if direcao.x > 0 else TEXTURA_ESQUERDA
		else:
			sprite.texture = TEXTURA_FRENTE if direcao.y > 0 else TEXTURA_COSTA
