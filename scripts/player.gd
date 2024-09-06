extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -500.0

var initial_logo_scale: Vector2

@onready var logo := $Logo
@onready var sparks := $Sparks
@onready var jump_sound := $Jump

func _ready() -> void:
	initial_logo_scale = $Logo.scale

# Fall faster than you jump
# adapted from https://www.youtube.com/watch?v=bn3ZUCZ0vMo
func get_custom_gravity():
	if velocity.y < 0:
		return get_gravity()
	return get_gravity() * 1.5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_custom_gravity() * delta
		logo.scale.y = move_toward(logo.scale.y, initial_logo_scale.y,  0.01)
		logo.scale.x = move_toward(logo.scale.x, initial_logo_scale.x,  0.01)
		
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

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
