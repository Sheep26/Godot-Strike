extends CharacterBody3D

@onready var camera: Camera3D = $Camera3D
@onready var menu = ResourceLoader.load("res://hud/IngameMenu.tscn")
@onready var gun = $Camera3D/Gun
@onready var raycast: RayCast3D = $Camera3D/RayCast3D
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var MOUSE_SENSITIVITY: float = 0.05
const MIN_LOOK_ANGLE: float = -90.0
const MAX_LOOK_ANGLE: float = 90.0
const RAY_LENGTH = 1000
var rotationYaw: float
var rotationPitch: float
var menuOpen: bool = false
var menu_instantiated

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and not menuOpen:
			rotation.y += -deg_to_rad(event.relative.x * MOUSE_SENSITIVITY)
			camera.rotation.x += -deg_to_rad(event.relative.y * MOUSE_SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(MIN_LOOK_ANGLE), deg_to_rad(MAX_LOOK_ANGLE))

func _process(_delta):
	rotationYaw = rotation.y
	rotationPitch = camera.rotation.x
	if Input.is_action_just_pressed("reload"):
		gun.currentGun._reload()
	if Input.is_action_just_pressed("chooseSecondary"):
		gun.currentGun = gun.glock18
	if Input.is_action_just_pressed("choosePrimary"):
		gun.currentGun = gun.ak47
	if Input.is_action_just_pressed("OPENMENU"):
		menuOpen = not menuOpen
		if menuOpen:
			menu_instantiated = menu.instantiate()
			get_tree().root.add_child(menu_instantiated)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			menu_instantiated.queue_free()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _shoot():
	camera.rotation.x += gun.currentGun.recoil
	if raycast.is_colliding():
		var target = raycast.get_collider()
		if target.is_in_group("Entity"):
			pass
	gun.currentGun.ammo -= 1
	gun.currentGun.canShoot = false
	gun.currentGun.firerate.start()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if (Input.is_action_just_pressed("fire") or (gun.currentGun.auto and Input.is_action_pressed("fire"))) and gun.currentGun.ammo > 0 and gun.currentGun.canShoot:
		_shoot()

	var input_dir = Input.get_vector("MOVELEFT", "MOVERIGHT", "MOVEFORWARD", "MOVEBACKWARDS")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
