# Spawner.gd
extends Node2D

@export var player: Node2D
@export var collectible_scene: PackedScene
@export var spawn_every: float = 0.75
@export var min_radius: float = 300.0
@export var max_radius: float = 600.0
@export var max_simultaneous: int = 50

var _timer: float = 0.0

func _process(delta: float) -> void:
	if player == null or collectible_scene == null:
		return

	_timer -= delta
	if _timer <= 0.0:
		_timer = spawn_every

		# Prevent overcrowding
		if get_tree().get_nodes_in_group("collectible").size() >= max_simultaneous:
			return

		# Pick a random point in a ring around the player
		var angle: float = randf() * TAU
		var radius: float = randf_range(min_radius, max_radius)
		var spawn_pos: Vector2 = player.global_position + Vector2(radius, 0).rotated(angle)

		# Spawn the collectible
		var c = collectible_scene.instantiate()
		c.global_position = spawn_pos

		# Option A: directly assign the player reference (no has_variable needed)
		c.player = player

		add_child(c)
