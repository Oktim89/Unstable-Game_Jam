extends RigidBody2D

var speed := 300.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	linear_velocity.x = direction * speed
