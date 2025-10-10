extends Area2D
const TILESIZE = 16

func _ready() -> void:
	position = Vector2(randi_range(0,40) * TILESIZE, randi_range(0,30) * TILESIZE)


func _on_body_entered(body: Node2D) -> void:
	body.get_parent().growTardigrade()
	get_parent().SpawnPlantCell()
	queue_free()
	pass # Replace with function body.
