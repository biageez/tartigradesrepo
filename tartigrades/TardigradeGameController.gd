extends Node2D
const TILESIZE = 16
var moveDelay = .15
var moveTimer = 0
var direction = Vector2(1,0)
var tardigradeBody = []

func _ready() -> void: 
	for i in range(3):
		var part = createPart(Vector2(-i, 0), i )
		tardigradeBody.append(part)
	pass
		
func _process(delta: float) -> void:
	moveTimer += delta
	if moveTimer >= moveDelay:
		moveTimer = 0
		moveTardigrade()
		
	if Input.is_action_just_pressed("ui_up") and direction != Vector2(0, 1):
		direction = Vector2(0, -1)
	if Input.is_action_just_pressed("ui_down") and direction != Vector2(0, -1):
		direction = Vector2(0, 1)
	if Input.is_action_just_pressed("ui_left") and direction != Vector2(1, 0):
		direction = Vector2(-1, 0)
	if Input.is_action_just_pressed("ui_right") and direction != Vector2(-1, 0):
		direction = Vector2(1, 0)

func growTardigrade():
	var middle = tardigradeBody[1]
	var sprite = middle.get_node_or_null("Sprite2D")
	if sprite:
		sprite.scale *= Vector2(1.2, 1.2) 
		
	moveDelay *= .95

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
		1: 
			sprite.texture = preload("res://middle.svg.png")
		2: 
			sprite.texture = preload("res://tail.svg")
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
