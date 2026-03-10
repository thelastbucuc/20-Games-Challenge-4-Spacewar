extends RigidBody2D

@export var engine_power: float = 800
@export var spin_power: float = 2000

var thrust: Vector2 = Vector2.ZERO
var rotation_dir: float = 0

@onready var screensize: Vector2 = get_viewport_rect().size

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


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var xform: Transform2D = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform
