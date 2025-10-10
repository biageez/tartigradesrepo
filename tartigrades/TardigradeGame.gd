extends Node2D

@export var Food : PackedScene

func SpawnPlantCell(): 
	call_deferred("spawnPlantCellDeferred")
	
func spawnPlantCellDeferred(): 
	add_child(Food.instantiate())
