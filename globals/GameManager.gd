extends Node

const MAIN: PackedScene = preload("uid://cm22brmholhms")
const MENU: PackedScene = preload("uid://ungi10lj851f")


func load_menu_scene() -> void:
	get_tree().change_scene_to_packed(MENU)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
