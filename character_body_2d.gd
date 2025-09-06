extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite2D= $Sprite2D
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (velocity.x > 1 or velocity.x < -1):
		sprite2D.play("run")
	else:
		sprite2D.play("default")

	
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite2D.play("jump")


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, 14)
		
	move_and_slide()
	var isleft=velocity.x<0
	sprite2D.flip_h = isleft
