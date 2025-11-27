extends CharacterBody2D

@export var speed: float = 200.0

var target_position: Vector2
var moving_to_click := false

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			target_position = event.position
			moving_to_click = true

func _physics_process(delta):
	var direction = Vector2.ZERO

	direction.x = (
		Input.get_action_strength("move_right") -
		Input.get_action_strength("move_left")
	)
	direction.y = (
		Input.get_action_strength("move_down") -
		Input.get_action_strength("move_up")
	)

	if direction.length() > 0:
		moving_to_click = false
		velocity = direction.normalized() * speed
		move_and_slide()
		return

	if moving_to_click:
		var to_target = target_position - global_position

		if to_target.length() > 5:
			velocity = to_target.normalized() * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO
			moving_to_click = false
	else:
		velocity = Vector2.ZERO
