extends Camera3D

@export var move_speed: float = 10.0  # Speed of movement
@export var mouse_sensitivity: float = 0.1  # Sensitivity of mouse movement

var yaw : float = 0.0  # Rotation around the Y axis (horizontal)
var pitch : float = 0.0  # Rotation around the X axis (vertical)
var speed_scale = 1

func _ready():
	# Hide the mouse cursor and capture it for first-person control
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	position = get_viewport().get_camera_3d().position

func _input(event):
	if event is InputEventMouseMotion:
		# Update yaw and pitch based on mouse movement
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		# Clamp pitch to avoid flipping the camera upside down
		pitch = clamp(pitch, -89.0, 89.0)


	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				speed_scale -= 0.1
				# call the zoom function
			# zoom out
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				speed_scale += 0.1 
				# call the zoom function

		speed_scale = max(speed_scale, 0.1)
		print(speed_scale)

func _process(delta: float):
	# Movement controls
	var direction : Vector3 = Vector3.ZERO

	# Calculate movement directions relative to the camera's orientation
	var forward : Vector3 = -global_transform.basis.z
	var right : Vector3 = global_transform.basis.x
	var up : Vector3 = global_transform.basis.y


	

	# Update direction based on key presses
	if Input.is_key_pressed(KEY_W):
		direction += forward
	if Input.is_key_pressed(KEY_S):
		direction -= forward
	if Input.is_key_pressed(KEY_A):
		direction -= right
	if Input.is_key_pressed(KEY_D):
		direction += right
	if Input.is_key_pressed(KEY_E):
		direction += up
	if Input.is_key_pressed(KEY_Q):
		direction -= up
 


	# Apply yaw and pitch rotations to the camera
	var yaw_basis : Basis = Basis(Vector3.UP, deg_to_rad(yaw))
	var pitch_basis : Basis = Basis(Vector3.RIGHT, deg_to_rad(pitch))
	transform.basis = yaw_basis * pitch_basis

	# Ensure the basis is properly oriented without roll
	transform.basis = transform.basis.orthonormalized()

	# Normalize direction and apply movement
	direction = direction.normalized() * (move_speed * speed_scale) * delta
	translate(direction * transform.basis)
