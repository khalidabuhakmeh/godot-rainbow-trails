extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var initial_logo_scale: Vector2

@onready var logo := $Logo
@onready var sparks := $Sparks
@onready var jump_sound := $Jump

func _ready() -> void:
	initial_logo_scale = $Logo.scale

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		logo.scale.y = move_toward(logo.scale.y, initial_logo_scale.y,  0.01)
		logo.scale.x = move_toward(logo.scale.x, initial_logo_scale.x,  0.01)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		sparks.emitting = true
		jump_sound.play()
		velocity.y = JUMP_VELOCITY
		logo.scale.y = initial_logo_scale.y * 1.5
		logo.scale.x = initial_logo_scale.x * 0.65

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = SPEED

	move_and_slide()
