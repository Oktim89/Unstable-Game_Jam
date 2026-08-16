extends RigidBody2D
var in_mouse_area
var follow= false
var is_picked_up:bool = false
var connected=false
var parent:Node = null
var in_connected_area
var  level_parent:Node 
var parent_pos

func _ready() -> void:
	level_parent =get_parent()
	
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
					gravity_scale=0.0
					follow=true
				elif event.is_released() and in_mouse_area:
					follow=false
					gravity_scale=1.0
					self.freeze=false
					attach_to_parent()
func _process(delta: float) -> void:
	
	if follow:
		global_position = get_global_mouse_position()
	
	else:
		if parent!=null:
			
			parent=null
			parent_pos=null
			
			

		
		
		


func _on_area_2d_mouse_entered() -> void:
	in_mouse_area=true
	


func _on_area_2d_mouse_exited() -> void:
	in_mouse_area=false


func attach_to_parent():
	if !in_connected_area:
		print("Not in edge area")
		reparent(level_parent)
		parent=null
		sleeping=false
		return
	if parent==null:
		print("No parent found")
		reparent(level_parent)
		parent=null
		sleeping=false
		return
	self.reparent(parent,true)
	connected=true
	
	


func _on_edge_area_entered(area: Area2D) -> void:
	in_connected_area=true
	if follow:
		parent= area.get_parent()
		#parent_pos= area.global_position


func _on_edge_area_exited(area: Area2D) -> void:
	in_connected_area=false
	#deattach_parent()
