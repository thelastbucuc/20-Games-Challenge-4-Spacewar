extends Node2D

const SHIP = preload("uid://e4vgnchdwf3o")

func _ready() -> void:
	SignalManager.on_round_start.connect(on_round_start)


func spawn_ships() -> void:
	for i in 2:
		var new_ship: Ship = SHIP.instantiate()
		new_ship.player = i + 1
		add_child(new_ship)


func on_round_start() -> void:
	for ship in get_tree().get_nodes_in_group("ships"):
		ship.queue_free()
	await get_tree().create_timer(0.5).timeout
	spawn_ships()
