extends Area2D

class_name Bullet

var _speed: float = 300.0
var _dir: Vector2 = Vector2.ZERO
var _color: Color = Color.WHITE

@onready var sprite_2d: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.modulate = _color
	await get_tree().create_timer(0.05).timeout
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += delta * _dir * _speed


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		print("bullet died")
	call_deferred("queue_free")
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
