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
var spawningSpots : Array[Dictionary] = [
	{"Raccoon" : [Vector3(-24, 62.861, 1), Vector3(-94,62.861,37), Vector3(-96,62.861,96), Vector3(-69,62.861,-8), Vector3(-26,62.861,51), Vector3(81,62.861,23), Vector3(-46,62.861,40), Vector3(81,62.861,95)]},
	{"Squirrel" : [Vector3(19.3, 67.105, -57.7), Vector3(76, 67.105, -49.5), Vector3(26.6, 67.105, -90), Vector3(28.6, 67.105, 99.5), Vector3(-51.2, 67.105, 104.8), Vector3(-101.766 + 12, 67.105, -89.935 + 3.5), Vector3(-40.582 + 12, 67.105, -65.329 + 3.5)]},
	{"Hawk" : [Vector3(7.3-7.6, 50.33, -60.8+2.5), Vector3(63.85-7.6, 50.33, -52.9+2.5), Vector3(14.65-7.6, 50.33, -115.3+2.5), Vector3(26.56-7.6, 50.33, 102.9+2.5), Vector3(-101.766-7.6, 50.33, -89.9+2.5), Vector3(-71-7.6, 50.33, 54.48+2.5), Vector3(14.65-7.6, 50.33, -115.3+2.5)]},
	{"Opossum" : [Vector3(40.6-.7, 35.99, 13.15+4.1), Vector3(26.56-.7, 35.99, 102.9+4.1), Vector3(-40.5-.7, 35.99, 67.85+4.1), Vector3(-70.9-.7, 35.99, -103+4.1), Vector3(-71-.7, 35.99, 54.5+4.1), Vector3(40.6-.7, 35.99, 13.15+4.1), Vector3(35.72-.7, 35.99, -60.2+4.1)]},
	{}]
#-.7, -+4.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#called via signal on player movement
func screen_enter(screenNum : int, player : CharacterBody3D):
	for i in get_children():
		i.queue_free()
	
	#for each animal has a chance to spawn them, chooses a unique location to position them in
	var animalsSpawned = 0
	for i in animalSpawnrates:
		if randf_range(0,100) <= animalSpawnrates[i] and animalsSpawned < 2:
			animalsSpawned += 1
			var temp = animalObjects[i].instantiate()
			var spot = randi_range(0, spawningSpots[i].size())
			temp.position = spawningSpots[i][spot]
			if screenNum == 1:
				temp.position.z += 266.7
			add_child(temp)
			
	#same but for enemies, max of 1 onscreen
	var enemiesSpawned = 0
	for i in enemySpawnrates:
		if randf_range(0,100) <= enemySpawnrates[i] and enemiesSpawned < 1:
			enemiesSpawned += 1
			var temp = enemyObjects[i].instantiate()
			var spot = randi_range(0, spawningSpots[i].size())
			temp.position = spawningSpots[i][spot]
			if screenNum == 1:
				temp.position.z += 266.7
			add_child(temp)


#called via signal on picture taken
func picture_taken() -> Array[String]:
	return []
