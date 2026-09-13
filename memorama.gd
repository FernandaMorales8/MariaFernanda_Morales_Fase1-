extends Node2D

var reverso = preload("res://Assets/Blue.png")

var cartas = [
	preload("res://Assets/cherry-1.png"),
	preload("res://Assets/cherry-1.png"),
	preload("res://Assets/gem-1.png"),
	preload("res://Assets/gem-1.png"),
	preload("res://Assets/Idle.png"),
	preload("res://Assets/Idle.png"),
	preload("res://Assets/item-feedback-3.png"),
	preload("res://Assets/item-feedback-3.png"),
]

var primera_carta = null
var segunda_carta = null

var primer_indice = -1
var bloqueado = false

func _ready():
	cartas.shuffle()

	for i in range(8):
		var boton = $GridContainer.get_child(i)
		boton.texture_normal = reverso
		boton.pressed.connect(voltear_carta.bind(boton, i))


func voltear_carta(boton, indice):
	if bloqueado:
		return

	if boton == primera_carta:
		return

	boton.texture_normal = cartas[indice]

	if primera_carta == null:
		primera_carta = boton
		primer_indice = indice
		return

	segunda_carta = boton
	bloqueado = true

	if cartas[primer_indice] == cartas[indice]:
		await get_tree().create_timer(0.4).timeout

		primera_carta.modulate.a = 0
		segunda_carta.modulate.a = 0

		primera_carta.disabled = true
		segunda_carta.disabled = true

		primera_carta = null
		segunda_carta = null
		primer_indice = -1
		bloqueado = false

	else:
		await get_tree().create_timer(1.0).timeout

		primera_carta.texture_normal = reverso
		segunda_carta.texture_normal = reverso

		primera_carta = null
		segunda_carta = null
		primer_indice = -1
		bloqueado = false
