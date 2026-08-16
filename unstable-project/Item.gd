extends Node2D
var in_area
var follow= false
var is_picked_up:bool = false
var connected=false


func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_area and event.button_index==1 and event.pressed:
					self.freeze= true
					follow=true
				if event.is_released():
					follow=false
					self.freeze=false
					
func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()
	
		
		


func _on_area_2d_mouse_entered() -> void:
	in_area=true
	


func _on_area_2d_mouse_exited() -> void:
	in_area=false
