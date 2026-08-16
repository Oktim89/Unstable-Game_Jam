extends RigidBody2D
var in_mouse_area=false
var follow= false
var connected= false
var parent = null
var in_conneted_area=false
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
					self.freeze= true
					follow=true
				if event.is_released():
					follow=false
					self.freeze=false
					switch_parent()
					
func switch_parent():
	if !in_conneted_area:
		return
	print(parent)
func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()
		
func _on_edge_area_entered(area: Area2D) -> void:
	in_conneted_area=true
	if follow:
		parent=area.get_parent()
	


func _on_mouse_area_mouse_entered() -> void:
	in_mouse_area=true


func _on_mouse_area_mouse_exited() -> void:
	in_mouse_area=false
	print("not in area")


func _on_edge_area_exited(area: Area2D) -> void:
	in_conneted_area=false
