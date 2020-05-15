extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const JUMPFORCE = 300
const MAXSPEED = 200

var vel = Vector2()
var can_jump = false
onready var sprite = $Sprite

func _ready():
	pass

func _physics_process(delta):
	
	vel.y += GRAVITY 
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	if input_x != 0:
		vel.x += input_x * SPEED
		vel.x = clamp(vel.x * input_x,SPEED * input_x,MAXSPEED * input_x)
		if input_x == -1:
			sprite.flip_h = true
			
		elif input_x == 1:
			sprite.flip_h = false
	else:
		vel.x = 0
	
	if is_on_floor():
		can_jump = true
		if Input.is_action_just_pressed("ui_up") and can_jump == true:
			vel.y = -JUMPFORCE
	else:
		can_jump = false
		
	vel = move_and_slide(vel,Vector2.UP)
