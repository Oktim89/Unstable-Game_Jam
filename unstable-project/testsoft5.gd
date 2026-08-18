extends SoftBody2D
var in_mouse_area=false
var follow= false
var connected= false
var parent:Node = null
var in_connected_area
var  level_parent:Node 







func _ready() -> void:
	level_parent =get_parent()
	



func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()
		



func _on_mouse_area_mouse_entered() -> void:
	in_mouse_area=true


func _on_mouse_area_mouse_exited() -> void:
	in_mouse_area=false
	



	
		

	
