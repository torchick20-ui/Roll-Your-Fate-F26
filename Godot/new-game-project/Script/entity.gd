extends Node3D
class_name entity

@onready var camera : CharacterBody3D = $"../PlayerController"
@export var entityName : String = "Tree"
@onready var sprite : Sprite3D = $Sprite3D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !camera:
		return
	var distFromCam = camera.distFromCamline(global_position, entityName == "Tree")

	if distFromCam < 8:
		sprite.modulate = Color(1.0, 1.0, 1.0)
	elif distFromCam < 10:
		sprite.modulate = Color(0.678, 0.561, 0.839, 1.0)
	elif distFromCam < 12:
		sprite.modulate = Color(0.514, 0.349, 0.686, 1.0)
	elif distFromCam < 14:
		sprite.modulate = Color(0.476, 0.322, 0.834, 1.0)
	else:
		sprite.modulate = Color(0.271, 0.176, 0.486)

func entity():
	pass
