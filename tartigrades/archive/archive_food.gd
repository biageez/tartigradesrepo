extends Area2D
const TILESIZE = 16
var collided = false

func _ready() -> void:
	randomize()
	var shape_node = get_parent().get_node_or_null("CollisionShape2DPlantCell")
	if shape_node:
		position = random_position_in_collision_shape(shape_node)
	else:
		# fallback if shape_node not found
		position = Vector2(randi_range(0, 40) * TILESIZE, randi_range(0, 30) * TILESIZE)

func random_position_in_collision_shape(shape_node: CollisionShape2D) -> Vector2:
	if shape_node.shape is RectangleShape2D:
		var rect_shape = shape_node.shape as RectangleShape2D
		var extents = rect_shape.extents
		var center = shape_node.global_position
		
		# Pick a random point inside rectangle bounds
		var rand_x = randf_range(-extents.x, extents.x)
		var rand_y = randf_range(-extents.y, extents.y)
		
		return center + Vector2(rand_x, rand_y)
	else:
		push_error("Unsupported shape type for random spawn.")
		return Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if collided: 
		return
		
	collided = true
	
	if body.get_parent().has_method("growTardigrade"):
		body.get_parent().growTardigrade()
	
	get_parent().SpawnPlantCell()
	queue_free()
	pass 


#func _ready() -> void:
	#position = Vector2(randi_range(0,40) * TILESIZE, randi_range(0,30) * TILESIZE)
#
#
#func _on_body_entered(body: Node2D) -> void:
	#body.get_parent().growTardigrade()
	#get_parent().SpawnPlantCell()
	#queue_free()
	#pass 
