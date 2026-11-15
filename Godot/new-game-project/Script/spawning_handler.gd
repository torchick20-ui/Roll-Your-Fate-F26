extends Node

#attached to a node which will be the parent of all the animals & entities
#whenever the player moves or takes a picture a signal will be sent to this node 
#for movement it will handle spawning of animals & entities, for pictures it will return what animals/entities are in the picture (?)


#Chance for each animal/entity to spawn on a player movement
var animalSpawnrates : Dictionary = {"Owl": 10, "Opossum" : 20, "Squirrel" : 30, "Hawk" : 5, "Raccoon" : 10}
var enemySpawnrates : Dictionary = {"Door" : 10, "Cup" : 10, "Vending Machine" : 10}

#Preloaded objects of the entities for instancing
var animalObjects : Dictionary[String,PackedScene] = {"Raccoon" : preload("res://Entites/racoon.tscn"), "Squirrel" : preload("res://Entites/flying_squirrel.tscn"), "Hawk" : preload("res://Entites/night_hawk.tscn"), "Owl" : preload("res://Entites/owl.tscn"), "Opossum" : preload("res://Entites/opossum.tscn")}
var enemyObjects : Dictionary = {"Cup" : preload("res://Entites/cup.tscn"), "Door" : preload("res://Entites/door.tscn"), "Vending Machine" : preload("res://Entites/vending_machine.tscn")}

#2D array of vector3s of possible spawning locations for the animals/entities
var spawningSpots : Dictionary[String, Array] = {
	"Raccoon" : [Vector3(-24, 62.861, 1), Vector3(-94,62.861,37), Vector3(-96,62.861,96), Vector3(-69,62.861,-8), Vector3(-26,62.861,51), Vector3(81,62.861,23), Vector3(-46,62.861,40), Vector3(81,62.861,95)],
	"Squirrel" : [Vector3(19.3, 67.105, -57.7), Vector3(76, 67.105, -49.5), Vector3(26.6, 67.105, -90), Vector3(28.6, 67.105, 99.5), Vector3(-51.2, 67.105, 104.8), Vector3(-101.766 + 12, 67.105, -89.935 + 3.5), Vector3(-40.582 + 12, 67.105, -65.329 + 3.5)],
	"Hawk" : [Vector3(7.3-7.6, 50.33, -60.8+2.5), Vector3(63.85-7.6, 50.33, -52.9+2.5), Vector3(14.65-7.6, 50.33, -115.3+2.5), Vector3(26.56-7.6, 50.33, 102.9+2.5), Vector3(-101.766-7.6, 50.33, -89.9+2.5), Vector3(-71-7.6, 50.33, 54.48+2.5), Vector3(14.65-7.6, 50.33, -115.3+2.5)],
	"Opossum" : [Vector3(40.6-.7, 35.99, 13.15+4.1), Vector3(26.56-.7, 35.99, 102.9+4.1), Vector3(-40.5-.7, 35.99, 67.85+4.1), Vector3(-70.9-.7, 35.99, -103+4.1), Vector3(-71-.7, 35.99, 54.5+4.1), Vector3(40.6-.7, 35.99, 13.15+4.1), Vector3(35.72-.7, 35.99, -60.2+4.1)],
	"Owl" : [Vector3(93.4-5, 73.29, 3.8-5), Vector3(54-5, 73.29, 69.2-5), Vector3(14.65-5, 73.29, -115.3-5), Vector3(35.72-5, 73.29, -60.2-5), Vector3(14.65-5, 73.29, 71.1-5), Vector3(-71-5, 73.29, 54.5-5), Vector3(51.4-5, 73.29, -104.6-5), Vector3(40.6-5, 73.29, 13.15-5)],
	"Cup" : [Vector3(0, 55, -100), Vector3(10, 20, -120), Vector3(30, 40, 30), Vector3(-50, 45, -50), Vector3(-40, 30, -100), Vector3(-70, 50, 50), Vector3(-30, 40, 80), Vector3(-5, 30, -50), Vector3(80, 40, 0), Vector3(90, 90, 20)],
	"Door" : [Vector3(0, 55, -100), Vector3(10, 20, -120), Vector3(30, 40, 30), Vector3(-50, 45, -50), Vector3(-40, 30, -100), Vector3(-70, 50, 50), Vector3(-30, 40, 80), Vector3(-5, 30, -50), Vector3(80, 40, 0), Vector3(90, 90, 20)],
	"Vending Machine" : [Vector3(0, 55, -100), Vector3(10, 20, -120), Vector3(30, 40, 30), Vector3(-50, 45, -50), Vector3(-40, 30, -100), Vector3(-70, 50, 50), Vector3(-30, 40, 80), Vector3(-5, 30, -50), Vector3(80, 40, 0), Vector3(90, 90, 20)]}
#-5, -5
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
			var spot = randi_range(0, spawningSpots[i].size() - 1)
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
			var spot = randi_range(0, spawningSpots[i].size() - 1)
			temp.position = spawningSpots[i][spot]
			if screenNum == 1:
				temp.position.z += 266.7
			add_child(temp)
