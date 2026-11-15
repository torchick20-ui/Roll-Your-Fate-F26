extends Button
var next_scene= preload("res://Scenes/Forest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.grab_focus.call_deferred()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	print("Start Pressed")
	get_tree().change_scene_to_packed(next_scene)
	pass
