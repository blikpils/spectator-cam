# spectator-cam
proper spectator cam written in GD script


Overview

This script implements a first-person spectator camera in Godot 4, allowing free movement and mouse-based camera rotation. The user can move the camera using the W, A, S, D, Q, and E keys, rotate the view using the mouse, and adjust the movement speed with the mouse wheel.
Key Features:

    Free Movement: Move in all directions using keyboard controls.
    Mouse Look: Rotate the camera using the mouse.
    Adjustable Speed: Zoom in and out to change movement speed.

Script Variables
move_speed (float)

    Default value: 10.0
    Description: The base speed of camera movement.

mouse_sensitivity (float)

    Default value: 0.1
    Description: Sensitivity of mouse movement for camera rotation. A higher value makes the camera rotate faster with smaller mouse movements.

yaw (float)

    Default value: 0.0
    Description: Horizontal camera rotation around the Y axis. Controlled by mouse movement along the X axis.

pitch (float)

    Default value: 0.0
    Description: Vertical camera rotation around the X axis. Controlled by mouse movement along the Y axis and clamped to avoid flipping.

speed_scale (float)

    Default value: 1
    Description: A multiplier for adjusting movement speed. It can be increased or decreased using the mouse wheel.

Methods
_ready()

    Description: This function is called when the node is added to the scene. It captures the mouse cursor to enable first-person control and sets the initial position of the camera.

gdscript

Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
position = get_viewport().get_camera_3d().position

_input(event)

    Description: Handles mouse movement and button input.

Mouse Movement

    Updates the camera's yaw and pitch based on mouse movement.
    Pitch is clamped between -89 and 89 degrees to prevent the camera from flipping upside down.

Mouse Wheel

    Zoom In: Scroll up to decrease the speed_scale and move more slowly.
    Zoom Out: Scroll down to increase the speed_scale and move faster.
    The speed scale cannot go below 0.1.

_process(delta: float)

    Description: This function is called every frame to update the camera's movement and rotation based on user input.

Movement

    Key controls:
        W/S: Move forward/backward.
        A/D: Move left/right.
        Q/E: Move down/up.
    Direction Calculation: The movement direction is calculated relative to the camera's orientation using the forward, right, and up vectors from the camera's global_transform.basis.

Rotation

    Yaw and Pitch are applied to the camera using Godot's Basis class to avoid rolling the camera.
    Orthonormalization: The camera's basis is normalized to maintain a stable orientation.

Movement Application

    The movement direction is normalized and scaled by the move_speed, speed_scale, and delta time factor. The camera is translated in the new direction accordingly.

Usage

    Attach this script to a Camera3D node in your scene.
    Adjust the exported move_speed and mouse_sensitivity values in the Godot editor to suit your preferences.
    Run the scene and use the following controls:
        W/A/S/D: Move the camera forward, backward, left, and right.
        Q/E: Move the camera down and up.
        Mouse Movement: Rotate the camera to look around.
        Mouse Wheel: Adjust movement speed.

Summary of Controls
Control	Action
W	Move forward
S	Move backward
A	Strafe left
D	Strafe right
Q	Move down
E	Move up
Mouse Movement	Look around
Mouse Wheel Up	Decrease movement speed (zoom in)
Mouse Wheel Down	Increase movement speed (zoom out)

This implementation provides a smooth and intuitive first-person camera system for use in 3D environments in Godot 4.
