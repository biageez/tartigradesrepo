extends Node2D
const TILESIZE = 16
const MOVEDELAY = .15
var moveTimer = 0
var direction = Vector2(1,0)
var tardigradeBody = []

func _ready() -> void: 
	for i in range(3):
		var part = createPart(Vector2(-i, 0), i==0 )
		tardigradeBody.append(part)
	pass
		
func _process(delta: float) -> void:
	moveTimer += delta
	if moveTimer >= MOVEDELAY:
		moveTimer = 0
		moveTardigrade()
		
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2(0,-1)
	if Input.is_action_just_pressed("ui_down"):
		direction = Vector2(0,1)
	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2(-1,0)
	if Input.is_action_just_pressed("ui_right"):
		direction = Vector2(1,0)
	
func moveTardigrade():
	var nextPosition = tardigradeBody[0].position + direction * TILESIZE
	
	for i in range(len(tardigradeBody) -1, 0, -1):
		tardigradeBody[i].position = tardigradeBody[i - 1].position
	
	tardigradeBody[0].position = nextPosition
	
	pass	

func createPart(position: Vector2, ishead: bool):
	var part = CharacterBody2D.new()
	part.position = position *  TILESIZE
	
	var sprite = Sprite2D.new()
	sprite.texture = preload("res://icon.svg")
	sprite.scale = Vector2(.2,.2)
	part.add_child(sprite)
	var collisionShape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(TILESIZE/2, TILESIZE/2)
	collisionShape.shape = shape
	part.add_child(collisionShape)
	
	add_child(part)
	return part
