extends Node

const MAIN: PackedScene = preload("uid://cm22brmholhms")


var Blue: Color = Color("#77bfff")
var Red: Color = Color("#ff7777")


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
