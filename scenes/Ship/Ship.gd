extends RigidBody2D

@export var engine_power: float = 800
@export var spin_power: float = 2000

var thrust: Vector2 = Vector2.ZERO
var rotation_dir: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	get_input()
	constant_force = thrust
	constant_torque = spin_power * rotation_dir


func get_input() -> void:
	thrust = Vector2.ZERO
	if Input.is_action_pressed("thrust"):
		thrust = transform.x * engine_power
	rotation_dir = Input.get_axis("turn_left", "turn_right")
