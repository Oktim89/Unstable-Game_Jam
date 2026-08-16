extends RigidBody2D
var in_mouse_area=false
var follow= false
var connected= false
var parent:Node = null
var in_connected_area
var  level_parent:Node 
@onready var right_spring: DampedSpringJoint2D= $Edge/RightSpring






func _ready() -> void:
	level_parent =get_parent()
	
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
				
					sleeping=true
					freeze=true
					follow=true
					gravity_scale=0.0
					linear_velocity=Vector2.ZERO
				if event.is_released() and in_mouse_area:
					linear_velocity=Vector2.ONE
					gravity_scale=1.0
					follow=false
					self.freeze=false
					
					



func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()
		linear_velocity=Vector2.ZERO



func _on_mouse_area_mouse_entered() -> void:
	in_mouse_area=true


func _on_mouse_area_mouse_exited() -> void:
	in_mouse_area=false
	




func _on_child_entered_tree(node: Node) -> void:
	if node is RigidBody2D:
		right_spring.node_a=node.get_path()
		var distance  = (global_position.length()-node.global_position.length())
		right_spring.rest_length=abs(distance)
		

	


func _on_child_exiting_tree(node: Node) -> void:
	right_spring.node_a =""
