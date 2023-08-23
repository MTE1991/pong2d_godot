extends KinematicBody2D

var speed = 400
var diff = 80
var ball 
var isHuman # false = AI, true = Human
var velocity

func _ready():
	ball = get_parent().find_node("Ball")

func _physics_process(delta):
	if not isHuman:
		move_and_slide(Vector2(0, get_opponent_direction()) * speed)
	else:
		velocity = Vector2.ZERO
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		move_and_slide(velocity * speed)

func get_opponent_direction():
	if abs(ball.position.y - position.y) > diff:
		if ball.position.y > position.y: return 1
		else: return -1
	else: return 0
