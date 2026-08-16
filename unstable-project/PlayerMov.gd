extends CharacterBody2D

const SPEED: float = 300.0
const PUSH_FORCE: float = 100.0

func _physics_process(delta: float) -> void:
	
	var mouse_position: Vector2 = get_global_mouse_position()

	# Move toward mouse
	var direction: Vector2 = global_position.direction_to(mouse_position)

	if global_position.distance_to(mouse_position) > 5.0:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# Push RigidBody2D objects
	for i in range(get_slide_collision_count()):
		var collision: KinematicCollision2D = get_slide_collision(i)
		var body: Node = collision.get_collider()

		if body is RigidBody2D:
			var normal: Vector2 = collision.get_normal()
			
			body.apply_central_force(-normal * PUSH_FORCE)
