extends CharacterBody2D

# Origem: trecho sugerido por IA (Manus), adaptado para o protótipo.
@export var velocidade: float = 100.0
@export var direcao: Vector2 = Vector2.LEFT

func _physics_process(_delta: float) -> void:
	velocity = direcao.normalized() * velocidade
	move_and_slide()
