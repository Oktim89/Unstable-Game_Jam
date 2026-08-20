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
@export var coils := 3
@export var segments_per_coil := 8
@export var amplitude := 2.0





@onready var bone_22: Bone2D = $"Skeleton2D/Bone-22"


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
		#var dir:Vector2 = (connected_node.global_position-bone_22.global_position)
		#var angle = dir.angle()
		#dir.rotated(angle)
		#spring_line.set_point_position(1,dir)
		update_spring()
	
		
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
	if area.get_parent() is RigidBody2D and connected_node==null:
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
func update_spring():
	var start = spring_line.to_local(connected_node.global_position)
	var end = spring_line.to_local(bone_22.global_position)

	spring_line.set_point_position(0, end)
	spring_line.set_point_position(1, start)
	var direction = end - start
	var spring_length = direction.length()
	if spring_length < 0.001:
		return
	direction = direction.normalized()
	var perpendicular = Vector2(
		-direction.y,
		direction.x
	)
	var points := PackedVector2Array()
	var total_points = coils * segments_per_coil
	for i in range(total_points + 1):
		var t = float(i) / float(total_points)
		var position = start.lerp(end, t)
		var offset = sin(t * coils * TAU) * amplitude
		position += perpendicular * offset
		points.append(position)
	points[0] = start
	points[points.size() - 1] = end
	spring_line.points = points
