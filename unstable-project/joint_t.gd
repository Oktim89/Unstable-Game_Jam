extends RigidBody2D

var speed := 3000.0

func _ready() -> void:
	print(get_ball_inertia())

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	linear_velocity.x = direction * speed*delta


func get_ball_inertia():
	return 1.0 / PhysicsServer2D.body_get_direct_state(get_rid()).inverse_inertia
