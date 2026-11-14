extends Node3D

var camera: Camera3D 
var film: int

var velocity: Vector2
var acceleration: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = $Camera3D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acceleration = Input.get_vector("Walk Left","Walk Right","Walk Forward","Walk Back")
	pass
