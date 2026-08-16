extends RigidBody2D
var in_mouse_area=false
var follow= false
var connected= false
var parent:Node = null
var in_connected_area
var  level_parent:Node 
@onready var spring: DampedSpringJoint2D = $Spring


func _ready() -> void:
	level_parent =get_parent()
	
func _input(event: InputEvent) -> void:

		if event is InputEventMouseButton:
				if in_mouse_area and event.button_index==1 and event.pressed:
					gravity_scale=0.0
					follow=true
				if event.is_released() and in_mouse_area:
					
					gravity_scale=1.0
					follow=false
					self.freeze=false
					
					



func _process(delta: float) -> void:
	if follow:
		position = get_global_mouse_position()


func _on_mouse_area_mouse_entered() -> void:
	in_mouse_area=true


func _on_mouse_area_mouse_exited() -> void:
	in_mouse_area=false
	




func _on_child_entered_tree(node: Node) -> void:
	if node is RigidBody2D:
		spring.node_a=node.get_path()
	
