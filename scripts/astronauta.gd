extends CharacterBody2D

# Movimento: referência à documentação oficial da Godot — CharacterBody2D e Input.get_vector().
# Troca das texturas: trecho sugerido por IA (Manus), adaptado para os sprites do projeto.

@export var velocidade: float = 220.0

const TEXTURA_FRENTE: Texture2D = preload("res://sprites/astronauta/frente.png")
const TEXTURA_COSTA: Texture2D = preload("res://sprites/astronauta/costa.png")
const TEXTURA_DIREITA: Texture2D = preload("res://sprites/astronauta/direita.png")
const TEXTURA_ESQUERDA: Texture2D = preload("res://sprites/astronauta/esquerda.png")

@onready var sprite: Sprite2D = $Sprite2D


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
