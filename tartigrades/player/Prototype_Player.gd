class_name Player
extends CharacterBody2D

#var base_speed: int = 15
#var max_speed := 500
#var currency_speed_multiplier := 0.5

#var speed: int = base_speed

@export var speed:float = 200

#@onready var currency_node = get_node("res://currency/Prototype_Save.gd")

func _physics_process(delta: float) -> void:
	#var currency = currency_node.currency
	
	#speed = clamp(base_speed + (currency * currency_speed_multiplier), base_speed, max_speed)
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("ui_down"):
		$AnimationPlayer.play("player_walk_down")
	
	if Input.is_action_pressed("ui_up"):
		$AnimationPlayer.play("player_walk_up")
		
	if Input.is_action_pressed("ui_left"):
		$AnimationPlayer.play("player_walk_left")
		
	if Input.is_action_pressed("ui_right"):
		$AnimationPlayer.play("player_walk_right")
