extends CharacterBody2D

# Origem: lógica sugerida por IA (Manus), adaptada ao protótipo.
@export var velocidade: float = 100.0
@export var direcao: Vector2 = Vector2.LEFT


func _physics_process(_delta: float) -> void:
	velocity = direcao.normalized() * velocidade
	move_and_slide()

	# Fragmentos não iniciam novas fragmentações.
	if get_meta("fragmento", false):
		return

	for i in range(get_slide_collision_count()):
		var outro = get_slide_collision(i).get_collider()

		if outro is CharacterBody2D and outro != self:
			if (
				has_meta("id_rajada")
				and outro.has_meta("id_rajada")
				and get_meta("id_rajada") == outro.get_meta("id_rajada")
				and not outro.get_meta("fragmento", false)
			):
				# Só o asteroide com ID menor processa este par.
				if get_instance_id() < outro.get_instance_id():
					_fragmentar_com(outro)
				return


func _fragmentar_com(outro: CharacterBody2D) -> void:
	var base: Vector2 = direcao.normalized() + outro.direcao.normalized()
	if base.length() < 0.01:
		base = direcao.normalized().orthogonal()
	else:
		base = base.normalized()

	# Origem: criação dos fragmentos sugerida por IA (Manus).
	for angulo in [-0.7, 0.0, 0.7]:
		var fragmento = duplicate() as CharacterBody2D
		get_parent().add_child(fragmento)

		fragmento.remove_meta("id_rajada")
		fragmento.set_meta("fragmento", true)
		#
		fragmento.collision_layer = 1 << 3 
		fragmento.collision_mask = 0       

		fragmento.global_position = global_position + base.rotated(angulo) * 12.0
		fragmento.scale = scale * 0.45
		fragmento.direcao = base.rotated(angulo)
		fragmento.velocidade = max(velocidade, outro.velocidade) * 2.0
		fragmento.velocity = Vector2.ZERO

	queue_free()
	outro.queue_free()
	
	
	
	
	# Origem: lógica sugerida por IA (Manus), adaptada ao Detector do asteroide.
func _on_detector_body_entered(body: Node2D) -> void:
	if not get_meta("fragmento", false):
		return
	if not body is CharacterBody2D or body == self:
		return

	direcao = -direcao.normalized()
	velocity = direcao * velocidade
