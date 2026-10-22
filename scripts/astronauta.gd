extends CharacterBody2D

# Referência: documentação oficial da Godot — CharacterBody2D e Input.get_vector().
@export var velocidade: float = 220.0

func _physics_process(_delta: float) -> void:
	var direcao := Input.get_vector("mover_esquerda", "mover_direita", "mover_cima", "mover_baixo")
	velocity = direcao * velocidade
	move_and_slide()
