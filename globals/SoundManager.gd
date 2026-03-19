extends Node

var sounds: Dictionary[String, AudioStream] = {}

func play_sound(player: Node, sound_path: String, one_shot: bool = false) -> void:
	if player.playing:
		player.stop()
	load_sound(sound_path)
	player.stream = sounds[sound_path]
	player.play()
	if one_shot:
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		player.reparent(self)
		await player.finished
		player.call_deferred("queue_free")

func load_sound(sound_path: String) -> void:
	if not sounds.has(sound_path):
		sounds[sound_path] = load(sound_path)
		print("loaded %s" % sound_path)
	else:
		print("already loaded %s" % sound_path)

func unload_sound(sound_path: String) -> void:
	sounds.erase(sound_path)
