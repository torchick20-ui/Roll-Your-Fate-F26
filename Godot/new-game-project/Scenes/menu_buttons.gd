extends Control

@export var buttons: Array[Button]
var current_button: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_button=0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_swap_button()
	
	pass

func _swap_button()->void:
	if Input.is_action_just_pressed("Walk Forward"):
		current_button= (current_button+1)%buttons.size()
	elif Input.is_action_just_pressed("Walk Back"):
		current_button= (current_button-1)%buttons.size()
	if current_button==0:
		buttons[0].focus_entered
		buttons[1].set_hovered(false)
	elif current_button==1:
		buttons[0].set_hovered(false)
		buttons[1].set_hovered(true)
	pass

#func _press_button()->void:
	
