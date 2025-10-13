extends Node2D

const TILESIZE = 16
var baseMoveDelay = .12
@export var minMoveDelay = .05
@export var maxMoveDelay = .12
@export var fuelSpeedCap = 500

var moveTimer = 0
var direction = Vector2(1,0)
var tardigradeBody = []
var new_direction = direction

func _ready() -> void: 
	for i in range(3):
		var part = createPart(Vector2(-i, 0), i )
		tardigradeBody.append(part)
	pass
		
func _process(delta: float) -> void:
	var fuel = get_parent().Fuel
	var fuel_ratio = clamp(get_parent().Fuel/fuelSpeedCap, 0, 1)
	var moveDelay = lerp(maxMoveDelay, minMoveDelay, fuel_ratio)
	
	
	if Input.is_action_just_pressed("ui_up"):
		if direction != Vector2(0, 1):
			new_direction = Vector2(0, -1)
	elif Input.is_action_just_pressed("ui_down"): 
		if direction != Vector2(0, -1):
			new_direction = Vector2(0, 1)
	elif Input.is_action_just_pressed("ui_left"):  
		if direction != Vector2(1, 0):
			new_direction = Vector2(-1, 0)
	elif Input.is_action_just_pressed("ui_right"):
		if direction != Vector2(-1, 0):
			new_direction = Vector2(1, 0)
	
	moveTimer += delta
	if moveTimer >= moveDelay:
		moveTimer = 0
		direction = new_direction
		moveTardigrade()
	

func growTardigrade():
	var middle = tardigradeBody[1]
	var sprite = middle.get_node_or_null("Sprite2D")
	if sprite:
		sprite.scale *= Vector2(1.01, 1.01) 
		#sprite.texture = preload("images of growing belly")
		
	get_parent().UpdateFuel()	
	#moveDelay *= .98

func moveTardigrade():
	var nextPosition = tardigradeBody[0].position + direction * TILESIZE
	
	for i in range(len(tardigradeBody) -1, 0, -1):
		tardigradeBody[i].position = tardigradeBody[i - 1].position
	
	tardigradeBody[0].position = nextPosition
	
	pass	

func createPart(position: Vector2, index: int):
	var part = CharacterBody2D.new()
	part.position = position *  TILESIZE
	
	var sprite = Sprite2D.new()
	
	match index: 
		0: 
			sprite.texture = preload("res://icon.svg")
			sprite.z_index = 2
		1: 
			sprite.texture = preload("res://middle.svg.png")
			sprite.z_index = 0
		2: 
			sprite.texture = preload("res://tail.svg")
			sprite.z_index = 2
		_: 
			sprite.texture = preload("res://middle.svg")
			
	sprite.name = "Sprite2D"
	sprite.scale = Vector2(.2,.2)
	part.add_child(sprite)
	
	var collisionShape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(TILESIZE/2, TILESIZE/2)
	
	collisionShape.shape = shape
	part.add_child(collisionShape)
	
	add_child(part)
	return part
