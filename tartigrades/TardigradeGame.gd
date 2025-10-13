extends Node2D

@export var Food : PackedScene
@export var fuel_decay_rate: float = 1.0

var Fuel = 0

func _process(delta: float) -> void:
	ConsumeFuel(delta)

func SpawnPlantCell(): 
	call_deferred("spawnPlantCellDeferred")
	
func spawnPlantCellDeferred(): 
	add_child(Food.instantiate())

func UpdateFuel(): 
	Fuel += 10
	$Fuel.text = "Fuel: " + str(round(Fuel))
	
func ConsumeFuel(delta: float) -> void: 
	if Fuel <= 0: 
		Fuel = 0
		return
	
	var decay_rate = fuel_decay_rate/100 #convert to percentage?
	var fuel_used = Fuel * decay_rate * delta
	Fuel -= fuel_used 
	$Fuel.text = "Fuel: " + str(round(Fuel))
