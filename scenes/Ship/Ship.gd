extends RigidBody2D

const BULLET: PackedScene = preload("uid://ct1df2lnrytx1")

@export var engine_power: float = 800
@export var spin_power: float = 2000

var thrust: Vector2 = Vector2.ZERO
var rotation_dir: float = 0
var _can_shoot: bool = true

@onready var screensize: Vector2 = get_viewport_rect().size
@onready var point: Marker2D = $Point
@onready var shoot_cooldown: Timer = $ShootCooldown

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
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var xform: Transform2D = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform


func shoot_bullet() -> void:
	if _can_shoot == true:
		var b: Bullet = BULLET.instantiate()
		b._dir = transform.x
		b.rotate(b.transform.x.angle_to(transform.x))
		b.global_position = point.global_position
		add_sibling(b)
		_can_shoot = false
		shoot_cooldown.start()


func die() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	call_deferred("queue_free")
	print("died")


func _on_hitbox_area_entered(_area: Area2D) -> void:
	die()


func _on_shoot_cooldown_timeout() -> void:
	_can_shoot = true
