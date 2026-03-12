extends Area2D

class_name Bullet

var _speed: float = 300.0
var _dir: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += delta * _dir * _speed


func _on_area_entered(_area: Area2D) -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	call_deferred("queue_free")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
