class_name Player_Character
extends CharacterBody3D


const SPEED = 5.0
#const RAY_LENGTH = 5.0

var sensitivity = 1.5
@onready var camera = $Camera3D
@onready var area_hit = $Camera3D/ShapeCast3D
@onready var reel = $Label
@onready var album = $TextureRect
#const JUMP_VELOCITY = 4.5
var picturesTaken = {"Owl" : false, "Raccoon" : false, "Squirrel" : false, "Hawk" : false, "Opossum" : false}
var film: int
var photos: Array
var open_album: bool
var album_position: int
var scene : int = 0

var turning : bool = false
var targetRot : float = 0
var startRot : float = 0
var turningTimer : float = 0

signal sceneChange(SceneNum : int, player : CharacterBody3D)

func _ready() -> void:
	for i in self.get_meta("exclude_detection"):
		area_hit.add_exception(get_node(i))
	film =self.get_meta("Film_Left")
	reel.set_text("Remaining Film: "+str(film)) #need to actually get the text, this isn't the right function.
	open_album = false
	album.set_visible(false)
	album_position=0;
	sceneChange.emit(0, self)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit Game"):
		_call_quit()
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("Walk Left","Walk Right","Walk Forward","Walk Back")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_just_pressed("Walk Left") and !turning:
		turning = true
		turningTimer = 0
		if scene == 0:
			scene = 1 
			startRot = 0
			targetRot = 180
			
		else:
			scene = 0
			startRot = -180
			targetRot = 0
	if Input.is_action_just_pressed("Walk Right") and !turning:
		turning = true
		turningTimer = 0
		if scene == 0:
			scene = 1 
			startRot = 0
			targetRot = -180
			
		else:
			scene = 0
			startRot = 180
			targetRot = 0

	if turning:
		rotation.y = deg_to_rad(lerpf(startRot, targetRot, turningTimer))
		turningTimer += delta
		if turningTimer >= 1:
			rotation.y = deg_to_rad(targetRot)
			turning = false
		sceneChange.emit(scene, self)
		
	move_and_slide()
	_look()
	if open_album ==true:
		if Input.is_action_just_pressed("Take Photo"):
			album_position= (album_position+1)%photos.size()
	else:
		_take_photo()
	
	_view_photos()


func _look()->void:
	
	#print(Input.is_action_pressed("Look Left"))
	var rotate = Input.get_vector("Look Left","Look Right","Look Up","Look Down")
	camera.rotation.y-=deg_to_rad(rotate.x*sensitivity)
	camera.rotation.x-=deg_to_rad(rotate.y*sensitivity)#We don't need to pitch the player up and down, but the camera.
	
	#clamps rotation to left and right
	if camera.rotation.y > 1.3:
		camera.rotation.y = 1.3
	if camera.rotation.y < -1.3:
		camera.rotation.y = -1.3
	
	#clamps rotation up and down
	if camera.rotation.x > .7:
		camera.rotation.x = .7
	if camera.rotation.x < -.8:
		camera.rotation.x = -.8
	rotate = Vector2()
	pass
	

func _take_photo()->void:
	if Input.is_action_just_pressed("Take Photo"):
		print("Photo taken")
		var hits = area_hit.collision_result
		var vending = false
		var screenshot = get_viewport().get_texture().get_image()#.get_region(screen_region)
		if hits.size()<=0:
			print ("Nothing found")
		else:
			for i in hits:
				if i.collider.get_parent().has_method("entity") and i.collider.get_parent().entityName == "Vending Machine":
					screenshot = preload("res://Images/VendingMachine.png")
					vending = true
			for i in hits:
				#var space_state = get_world_3d().direct_space_state
				#var origin = camera.global_position
				#var end = origin + (i.point * RAY_LENGTH)
				#var query = PhysicsRayQueryParameters3D.create(origin, end)
				#var result = space_state.intersect_ray(query)
				#if result.get_collider().get_parent().get_script().get_global_name() == :
				if i.collider.get_parent().has_method("entity") and i.collider.get_parent().entityName != "Tree" and not vending:
					var temp = i.collider.get_parent().entityName
					print(i.collider.get_parent().entityName)
					if temp in picturesTaken:
						picturesTaken[temp] = true
					elif temp == "Cup":
						film -= 5
					elif temp == "Door":
						get_tree().change_scene_to_file("res://Scenes/door scene.tscn")
				#print(i.collider_id)
				
		#var screen_region := Rect2i(get_viewport().siz, size) 
		photos.push_back(screenshot)
		film-=1
		reel.set_text("Remaining Film: "+str(film))
		var win = true
	
		for i in picturesTaken:
			if not i:
				win = false
		if win:
			$Label3.visible = true
			


func _view_photos()->void:
	if Input.is_action_just_pressed("Check Camera"):
		if open_album ==true:
			print("Close Album")
			open_album=false
			album.set_visible(false)
		else:
			print("Open Album")
			open_album=true
			album.set_visible(true)
			
	if !photos.is_empty():
				album.set_texture(ImageTexture.create_from_image(photos[album_position]))
	pass

func distFromCamline(pos : Vector3, isTree : bool) -> float:
	var rPos = pos
	if isTree:
		rPos.y = 0
	var minDist = 10000000
	for i in $Camera3D/DistanceCheckNodes.get_children():
		var pPos = i.global_position
		if isTree:
			pPos.y = 0
		if minDist > rPos.distance_to(pPos):
			minDist = rPos.distance_to(pPos)
	return minDist

func _call_quit()->void:
	get_tree().quit()
