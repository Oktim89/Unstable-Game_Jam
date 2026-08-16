extends RigidBody2D
var in_mouse_area=false
var follow= false
var connected= false
var parent:Node = null
var in_connected_area
var  level_parent:Node 


func _ready() -> void:
	level_parent =get_parent()
	
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
					self.freeze= true
					follow=true
				if event.is_released():
					follow=false
					self.freeze=false
					attach_to_parent()
					
func attach_to_parent():
	if !in_connected_area:
		reparent(level_parent)
		return
	if parent==null:
		reparent(level_parent)
		return
	print(parent)
	self.reparent(parent,true)
	connected=true
	parent=null
func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()
		
func _on_edge_area_entered(area: Area2D) -> void:
	in_connected_area=true
	if follow:
		parent=area.get_parent()
	


func _on_mouse_area_mouse_entered() -> void:
	in_mouse_area=true


func _on_mouse_area_mouse_exited() -> void:
	in_mouse_area=false
	


func _on_edge_area_exited(area: Area2D) -> void:
	in_connected_area=false
