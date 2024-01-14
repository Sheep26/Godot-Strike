extends CharacterBody3D

@onready var camera: Camera3D = $Camera3D
@onready var menu = ResourceLoader.load("res://hud/IngameMenu.tscn")
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
const MIN_LOOK_ANGLE: float = -90.0
const MAX_LOOK_ANGLE: float = 90.0
var look_sensitivity: float = 0.05
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
			rotation.y += -deg_to_rad(event.relative.x * look_sensitivity)
			camera.rotation.x += -deg_to_rad(event.relative.y * look_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(MIN_LOOK_ANGLE), deg_to_rad(MAX_LOOK_ANGLE))

func _process(_delta):
	rotationYaw = rotation.y
	rotationPitch = camera.rotation.x
	if Input.is_action_just_pressed("OPENMENU"):
		menuOpen = not menuOpen
		if menuOpen:
			menu_instantiated = menu.instantiate()
			get_tree().root.add_child(menu_instantiated)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().root.remove_child(menu_instantiated)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("MOVELEFT", "MOVERIGHT", "MOVEFORWARD", "MOVEBACKWARDS")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
