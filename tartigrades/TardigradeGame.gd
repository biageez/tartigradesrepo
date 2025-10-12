extends Node2D

@export var Food : PackedScene

var Fuel = 0

func SpawnPlantCell(): 
	call_deferred("spawnPlantCellDeferred")
	
func spawnPlantCellDeferred(): 
	add_child(Food.instantiate())

func UpdateFuel(): 
	Fuel += 1
	$Fuel.text = "Fuel: " + str(Fuel)
