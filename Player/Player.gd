extends KinematicBody2D

var speed = 400 
var velocity

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	move_and_slide(velocity * speed)

func stop_player():
	speed = 0
	
func start_player():
	speed = 400
