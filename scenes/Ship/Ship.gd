extends RigidBody2D

const BULLET: PackedScene = preload("uid://ct1df2lnrytx1")

@export var player: int = 1
@export var engine_power: float = 800
@export var spin_power: float = 2000

var thrust: Vector2 = Vector2.ZERO
var rotation_dir: float = 0
var _can_shoot: bool = true
var _delta: float = 0
var _star_gravity_power: float = 120.0
var _star: Area2D

@onready var screensize: Vector2 = get_viewport_rect().size
@onready var point: Marker2D = $Point
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_star = get_parent().get_child(0)
	if player == 1:
		sprite_2d.modulate = GameManager.Blue
	elif player == 2:
		sprite_2d.modulate = GameManager.Red


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_delta = delta
	get_input()
	constant_force = thrust
	constant_torque = spin_power * rotation_dir
	constant_force += global_position.direction_to(_star.global_position) * _star_gravity_power


func get_input() -> void:
	thrust = Vector2.ZERO
	if player == 1:
		if Input.is_action_pressed("thrust"):
			thrust = transform.x * engine_power
		rotation_dir = Input.get_axis("turn_left", "turn_right")
		if Input.is_action_just_pressed("shoot"):
			shoot_bullet()
	elif player == 2:
		if Input.is_action_pressed("thrust_2"):
			thrust = transform.x * engine_power
		rotation_dir = Input.get_axis("turn_left_2", "turn_right_2")
		if Input.is_action_just_pressed("shoot_2"):
			shoot_bullet()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var xform: Transform2D = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform


func shoot_bullet() -> void:
	if _can_shoot == true:
		var b: Bullet = BULLET.instantiate()
		if player == 1:
			b._color = GameManager.Blue
		elif player == 2:
			b._color = GameManager.Red
		b._dir = transform.x
		b.rotate(b.transform.x.angle_to(transform.x))
		b.global_position = point.global_position
		add_sibling(b)
		_can_shoot = false
		shoot_cooldown.start()


func die() -> void:
	call_deferred("set_process_mode", false)
	call_deferred("queue_free")


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		print("player%s died from crashing to another player" % str(player))
	elif area.collision_layer == 2:
		print("player%s died from bullet" % str(player))
	die()


func _on_shoot_cooldown_timeout() -> void:
	_can_shoot = true
