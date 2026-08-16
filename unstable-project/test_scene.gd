extends Node2D
func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode= Input.MOUSE_MODE_VISIBLE
