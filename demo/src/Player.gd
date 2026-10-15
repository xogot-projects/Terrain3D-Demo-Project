extends CharacterBody3D

@export var MOVE_SPEED: float = 50.0
@export var JUMP_SPEED: float = 2.0
@export var first_person: bool = false : 
	set(p_value):
		first_person = p_value
		if first_person:
			var tween: Tween = create_tween()
			tween.tween_property($CameraManager/Arm, "spring_length", 0.0, .33)
			tween.tween_callback($Body.set_visible.bind(false))
		else:
			$Body.visible = true
			create_tween().tween_property($CameraManager/Arm, "spring_length", 6.0, .33)

@export var gravity_enabled: bool = true :
	set(p_value):
		gravity_enabled = p_value
		if not gravity_enabled:
			velocity.y = 0
			
@export var collision_enabled: bool = true :
	set(p_value):
		collision_enabled = p_value
		$CollisionShapeBody.disabled = ! collision_enabled
		$CollisionShapeRay.disabled = ! collision_enabled


func _physics_process(p_delta) -> void:
	var direction: Vector3 = get_camera_relative_input()
	var strength := Input.get_vector("move_left", "move_right", "move_forward", "move_back").length()
	var h_veloc: Vector2 = Vector2(direction.x, direction.z).normalized() * MOVE_SPEED * strength
	if (Input.is_action_just_released("move_up") or Input.is_action_just_released("move_down")) and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		velocity.y = 0
	if Input.is_key_pressed(KEY_SHIFT):
		h_veloc *= 2
	velocity.x = h_veloc.x
	velocity.z = h_veloc.y
	if gravity_enabled:
		velocity.y -= 40 * p_delta
	move_and_slide()
	# Allow player to walk on waves in the ocean
	if get_parent().terrain and get_parent().terrain.get("ocean_enabled") == true:
		position.y = max(3, position.y)


# Returns the input vector relative to the camera. Forward is always the direction the camera is facing
func get_camera_relative_input() -> Vector3:
	var movement := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var input_dir: Vector3 = %Camera3D.global_transform.basis * Vector3(movement.x, 0, movement.y)
	if Input.is_action_pressed("move_up"):
		velocity.y += JUMP_SPEED + MOVE_SPEED*.016
	if Input.is_action_pressed("move_down"):
		velocity.y -= JUMP_SPEED + MOVE_SPEED*.016
	if Input.is_key_pressed(KEY_KP_ADD) or Input.is_key_pressed(KEY_EQUAL):
		MOVE_SPEED = clamp(MOVE_SPEED + .5, 5, 9999)
	if Input.is_key_pressed(KEY_KP_SUBTRACT) or Input.is_key_pressed(KEY_MINUS):
		MOVE_SPEED = clamp(MOVE_SPEED - .5, 5, 9999)
	return input_dir


func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseButton and p_event.pressed:
		if p_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			MOVE_SPEED = clamp(MOVE_SPEED + 5, 5, 9999)
		elif p_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			MOVE_SPEED = clamp(MOVE_SPEED - 5, 5, 9999)
	
	elif p_event is InputEventKey:
		if p_event.pressed:
			if p_event.keycode == KEY_V:
				first_person = ! first_person
			elif p_event.keycode == KEY_G:
				gravity_enabled = ! gravity_enabled
			elif p_event.keycode == KEY_C:
				collision_enabled = ! collision_enabled
