extends Node

#attached to a node which will be the parent of all the animals & entities
#whenever the player moves or takes a picture a signal will be sent to this node 
#for movement it will handle spawning of animals & entities, for pictures it will return what animals/entities are in the picture (?)


#Chance for each animal/entity to spawn on a player movement
var animalSpawnrates : Dictionary = {"Owl": 10, "Possum" : 20, "Squirrel" : 50}
var enemySpawnrates : Dictionary = {"Door" : 5, "Cup" : 5, "Vending Machine" : 5}

#Preloaded objects of the entities for instancing
var animalObjects : Dictionary[String,PackedScene] = {}
var enemyObjects : Dictionary = {}

#2D array of vector3s of possible spawning locations for the animals/entities
var spawningSpots : Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#called via signal on player movement
func screen_enter(screenNum : int, player : CharacterBody3D):
	#marking what spots have entities in them
	var spotsTaken = []
	for i in range(spawningSpots[screenNum].size()):
		spotsTaken.append(false)
	
	#for each animal has a chance to spawn them, chooses a unique location to position them in
	var animalsSpawned = 0
	for i in animalSpawnrates:
		if randf_range(0,100) <= animalSpawnrates[i] and animalsSpawned < 2:
			animalsSpawned += 1
			var temp = animalObjects[i].instantiate()
			#prevents multiple things from taking up the same spot
			var spot = randi_range(0, spawningSpots[screenNum].size())
			while !spotsTaken[spot]:
				spot = randi_range(0, spawningSpots[screenNum].size())
			temp.position = spawningSpots[screenNum][spot]
			add_child(temp)
			
	#same but for enemies, max of 1 onscreen
	var enemiesSpawned = 0
	for i in enemySpawnrates:
		if randf_range(0,100) <= enemySpawnrates[i] and enemiesSpawned < 1:
			enemiesSpawned += 1
			var temp = enemyObjects[i].instantiate()
			#prevents multiple things from taking up the same spot
			var spot = randi_range(0, spawningSpots[screenNum].size())
			while !spotsTaken[spot]:
				spot = randi_range(0, spawningSpots[screenNum].size())
			temp.position = spawningSpots[screenNum][spot]
			add_child(temp)
	

#called via signal on picture taken
func picture_taken(picture : Area3D) -> Array[String]:
	return []
