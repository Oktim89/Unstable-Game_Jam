extends RigidBody2D


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		apply_central_force(Vector2(5000, 0))
