extends RigidBody2D
class_name Weapon


var in_mouse_area
var follow= false
var is_picked_up:bool = false
var connected=false
var parent:Node = null
var in_connected_area
var  level_parent:Node 
var parent_pos
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var blocker: ColorRect = $Blocker

func _ready() -> void:
	level_parent =get_parent()
	
	
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
					sleeping=true
					freeze=true
					follow=true
					collision_shape_2d.disabled=true
					gravity_scale=0.0
					linear_velocity=Vector2.ZERO
				elif event.is_released() and in_mouse_area:
					follow=false
					linear_velocity=Vector2.ONE
					freeze=false
					collision_shape_2d.disabled=false
					gravity_scale=1.0
					attach_to_parent()
func _process(delta: float) -> void:
	if follow:
		global_position = get_global_mouse_position()
		linear_velocity=Vector2.ZERO
	
	else:
		if parent!=null:
			
			parent=null
			parent_pos=null
		
			

		
		
		




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
	gravity_scale=1.0
	sleeping=false
	
	connected=true
	
	


func _on_edge_area_entered(area: Area2D) -> void:
	in_connected_area=true
	if follow:
		parent= area.get_parent()
		#parent_pos= area.global_position


func _on_edge_area_exited(area: Area2D) -> void:
	in_connected_area=false
	#deattach_parent()


func _on_mouse_area_mouse_entered() -> void:
	pass
	#in_mouse_area=true


func _on_mouse_area_mouse_exited() -> void:
	pass
	#in_mouse_area=false


func _on_blocker_mouse_entered() -> void:
	in_mouse_area=true


func _on_blocker_mouse_exited() -> void:
	in_mouse_area=false
