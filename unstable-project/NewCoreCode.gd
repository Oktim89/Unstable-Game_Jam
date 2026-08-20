extends SoftBody2D
var in_mouse_area=false
var follow= false
var connected= false
var parent:Node = null
var in_connected_area
var  level_parent:Node 
var connected_node:RigidBody2D = null
@onready var right_spring: DampedSpringJoint2D = $"Skeleton2D/Bone-22/Edge/RightSpring"
@onready var spring_line: Line2D = $"Skeleton2D/Bone-22/Line2D"








func _ready() -> void:
	level_parent =get_parent()
	spring_line.visible=false
	spring_line.closed=true
	spring_line.add_point(global_position,1)
	
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
				
					#sleeping=true
					#freeze=true
					follow=true
				
				
				if event.is_released() and in_mouse_area:
				
				
					follow=false
		
					
					
func _process(delta: float) -> void:
	
	if follow:
		position = get_global_mouse_position()
	if right_spring.node_a and connected_node!=null:
		spring_line.visible=true
		#spring_line.set_point_position(0,)
		spring_line.set_point_position(1,connected_node.global_position-spring_line.global_position)
		
		
func _on_child_entered_tree(node: Node) -> void:
	if node is RigidBody2D:
		right_spring.node_a = node.get_path()
		print('true')
		
		

		var distance  = abs(global_position.length()-node.global_position.length())
		right_spring.rest_length = distance 

func _on_mouse_area_area_entered(area: Area2D) -> void:
	in_mouse_area = true


func _on_mouse_area_area_exited(area: Area2D) -> void:
	in_mouse_area = false


func _on_edge_2_area_entered(area: Area2D) -> void:
	pass

func _on_edge_2_area_exited(area: Area2D) -> void:
	pass # Replace with function body.


func _on_edge_area_entered(area: Area2D) -> void:
	if area.get_parent() is RigidBody2D:
		right_spring.node_a = area.get_parent().get_path()
		connected_node = area.get_parent()
		print('true')
		var distance  = abs(global_position.length()-area.global_position.length())
		right_spring.rest_length = distance -10.0


func _on_edge_area_exited(area: Area2D) -> void:
	print("Left the edge")
	right_spring.node_a=""
	connected_node=null
	spring_line.visible=false
