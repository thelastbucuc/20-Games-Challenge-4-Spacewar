extends CanvasLayer

@onready var start_menu: Control = $StartMenu
@onready var win: Control = $Win
@onready var player_label: Label = $Win/VBoxContainer/PlayerLabel
@onready var restart_label: Label = $Win/VBoxContainer/RestartLabel
@onready var restart_timer: Timer = $Win/RestartTimer
@onready var sound: AudioStreamPlayer = $StartMenu/Sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_died.connect(on_died)
	get_tree().paused = true


func _process(_delta: float) -> void:
	if restart_timer.time_left > 0:
		restart_label.text = "Restarting in %s..." % int(restart_timer.time_left)


func _on_button_pressed() -> void:
	start_menu.hide()
	get_tree().paused = false
	SoundManager.play_sound(sound, "res://assets/select_003.ogg")


func on_died(player: int) -> void:
	get_tree().paused = true
	SoundManager.play_sound(sound, "res://assets/confirmation_001.ogg")
	win.show()
	restart_timer.start()
	if player == 1:
		player_label.text = "Player 2 won!"
	if player == 2:
		player_label.text = "Player 1 won!"
	await get_tree().create_timer(0.2).timeout


func _on_restart_timer_timeout() -> void:
	win.hide()
	get_tree().paused = false
	SignalManager.emit_on_round_start()
