class_name Player
extends CharacterBody2D

@export var speed : float = 200
@export var animation_tree: AnimationTree

var input : Vector2
var playback : AnimationNodeStateMachinePlayback

func _ready(): 
	playback = animation_tree["parameters/playback"]
	spawn_belly()

func _physics_process(delta: float) -> void:
	input = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
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
	animation_tree["parameters/Walk/blend_position"] = input
	animation_tree["parameters/Idle/blend_position"] = input

func spawn_belly(): 
	var belly_scene = preload("res://player/Prototype_Player_Belly.tscn")
	var sprite_node = get_node("Sprite2D")
	
	#--- First Belly ---
	var belly1 = belly_scene.instantiate()
	sprite_node.add_child(belly1)
	belly1.position = Vector2(0,560.0)
	belly1.set_meta("target_position", belly1.position)
	var anim_belly1 = belly1.get_node_or_null("AnimationPlayer")
	if anim_belly1: 
		anim_belly1.play("Belly_Walk")

	#--- Second Belly ---
	var belly2 = belly_scene.instantiate()
	sprite_node.add_child(belly2)
	belly2.position = Vector2(0, 1080)
	belly2.scale.x = -1
	belly2.set_meta("target_position", belly2.position)
	var anim_belly2 = belly2.get_node_or_null("AnimationPlayer")
	if anim_belly2: 
		anim_belly2.play("Belly_Walk")
		


# ---------------Notes---------------

#var base_speed: int = 15
#var max_speed := 500
#var currency_speed_multiplier := 0.5

#var speed: int = base_speed

#@onready var currency_node = get_node("res://currency/Prototype_Save.gd")

#var currency = currency_node.currency
	
	#speed = clamp(base_speed + (currency * currency_speed_multiplier), base_speed, max_speed)
	
