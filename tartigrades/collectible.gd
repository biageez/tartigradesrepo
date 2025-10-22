extends Area2D

@export var drift_speed: float = 20.0
@export var attract_radius: float = 200.0
@export var attract_speed: float = 140.0

var player: Node2D

func _ready() -> void:
	add_to_group("collectible")
	rotation = randf() * TAU  # random drift direction
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	body_entered.connect(_on_body_entered)
	monitoring = true  # make sure the Area is active

func _process(delta: float) -> void:
	if player:
		var to_player := player.global_position - global_position
		var dist := to_player.length()
		if dist <= attract_radius:
			global_position += to_player.normalized() * attract_speed * delta
			return
	# gentle drift when not attracted
	global_position += Vector2.RIGHT.rotated(rotation) * drift_speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		queue_free()
