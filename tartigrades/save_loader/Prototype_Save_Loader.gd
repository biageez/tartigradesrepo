class_name SaveLoader
extends Node

@onready var _player:Player = %Player as Player

#@export var currency := 0
#@export var player_level int := 0
#@export var player_global_position := Vector2(0,0)

func save_game():
	var saved_game := SavedGame.new()
	
	saved_game.player_position = _player.global_position
	#save currency 
	#save player upgrades  
	#save time till food is replenished
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var saved_game = ResourceLoader.load("user://savegame.tres") as SavedGame
	
	if saved_game == null: 
		return
	
	_player.global_position = saved_game.player_position
	
		
