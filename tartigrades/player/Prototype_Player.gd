class_name Player
extends CharacterBody2D

#var base_speed: int = 15
#var max_speed := 500
#var currency_speed_multiplier := 0.5

#var speed: int = base_speed

@export var speed := 30
@export var animation_tree: AnimationTree
var input
var playback : AnimationNodeStateMachinePlayback
#@onready var currency_node = get_node("res://currency/Prototype_Save.gd")

func _ready():
	playback = animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	#var currency = currency_node.currency
	#speed = clamp(base_speed + (currency * currency_speed_multiplier), base_speed, max_speed)
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input * speed
	move_and_slide()
	select_animation()
	update_animation_parameters()
	
func select_animation():
	if velocity == Vector2.ZERO:
		playback.travel("Idle")
	else: 
		playback.travel("Walk")
	
func update_animation_parameters():
	if input == Vector2.ZERO:
		return
	
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input
	
