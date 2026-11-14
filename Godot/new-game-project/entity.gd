extends Node3D
class_name entity

var camera : Area3D = null
@export var sprites :  Array[Sprite2D] = []
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !camera:
		return
	if global_position.distance_to(camera.global_position) < 5:
		sprite.texture = sprites[1]
	else:
		sprite.texture = sprites[0]
