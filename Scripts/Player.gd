extends CharacterBody2D

const moveSpeed = 70
const maxSpeed = 100
const jumpHeight = -300
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer



func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	if Input.is_key_label_pressed(KEY_D):
		sprite.flip_h = false
		animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)

	elif Input.is_key_label_pressed(KEY_A):
		sprite.flip_h = true
		animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)

	else:
		animationPlayer.play("Idle")
		friction = true

	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jumpHeight
			animationPlayer.play("Jump")
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01)

	move_and_slide()
