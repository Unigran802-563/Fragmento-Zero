extends Control

# Origem: lógica sugerida por IA (Manus), adaptada ao projeto.

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/arena.tscn")


func _on_botao_reiniciar_pressed() -> void:
	# Origem: lógica sugerida por IA (Manus), adaptada ao projeto.
	get_tree().change_scene_to_file("res://scenes/arena.tscn")
