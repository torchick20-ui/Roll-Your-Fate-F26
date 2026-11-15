extends Node3D
class_name entity

@onready var camera : CharacterBody3D = $"../PlayerController"
@export var sprites :  Array[Texture] = []
@export var entityName : String = "Vending Machine"
@onready var sprite = $Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = sprites[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !camera:
		return
	if global_position.distance_to(camera.global_position) < 6:
		sprite.texture = sprites[1]
	else:
		sprite.texture = sprites[0]

func entity():
	pass
