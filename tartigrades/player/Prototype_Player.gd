class_name Player
extends CharacterBody2D

@export var speed : float = 200
@export var animation_tree: AnimationTree
@export var rotation_speed := 1.0

var input : Vector2
var playback : AnimationNodeStateMachinePlayback

var sprite_head
var belly1 
var belly2


func _ready(): 
	playback = animation_tree["parameters/playback"]
	spawn_belly()

func _physics_process(delta: float) -> void:
	input = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	velocity = input * speed
	
	move_and_slide()
	select_animation()
	update_animation_parameters()
	rotate_belly(delta)
	
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
	sprite_head = get_node("Sprite2D")
	
	#--- First Belly ---
	belly1 = belly_scene.instantiate()
	sprite_head.add_child(belly1)
	belly1.position = Vector2(0,560.0)
	var anim_belly1 = belly1.get_node_or_null("AnimationPlayer")
	if anim_belly1: 
		anim_belly1.play("Belly_Walk")

	#--- Second Belly ---
	belly2 = belly_scene.instantiate()
	sprite_head.add_child(belly2)
	belly2.position = Vector2(0, 1080)
	#belly2.scale.x = -1
	var anim_belly2 = belly2.get_node_or_null("AnimationPlayer")
	if anim_belly2: 
		anim_belly2.play("Belly_Walk")
		
func rotate_belly(delta):
	belly1.rotation = lerp_angle(belly1.rotation, sprite_head.rotation, rotation_speed * delta)


# ---------------Notes---------------

#var base_speed: int = 15
#var max_speed := 500
#var currency_speed_multiplier := 0.5

#var speed: int = base_speed

#@onready var currency_node = get_node("res://currency/Prototype_Save.gd")

#var currency = currency_node.currency
	
	#speed = clamp(base_speed + (currency * currency_speed_multiplier), base_speed, max_speed)
	
