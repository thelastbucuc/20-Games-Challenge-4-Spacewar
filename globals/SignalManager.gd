extends Node

signal on_died(player: int)
signal on_round_start


func emit_on_died(player: int) -> void:
	on_died.emit(player)


func emit_on_round_start() -> void:
	on_round_start.emit()
