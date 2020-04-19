extends KinematicBody2D

# Bat movement speed
export var speed = 3000.0
var direction: Vector2 = Vector2(0.0, 0.0)
var life = 50
var dead = false

var chasing = null

func _ready():
	print("Bat ready")
	$Vision.connect("body_entered", self, "seen")
	$Vision.connect("body_exit", self, "forgotten")
	
func seen(body):
	print('seen', body)
	if body.get("isPlayer"): 
		chasing = body

func forgotten(body):
	print('forgotten', body)
	if body.get("isPlayer"): 
		chasing = null

func _physics_process(delta):
	# Get player input
	direction.x += (randf() - 0.5)
	direction.y += (randf() - 0.5)
	
	if chasing:
		var tendency = chasing.position - self.position
		tendency = tendency.normalized() / 2.0
		direction += tendency
	
	direction = direction.normalized()
	
	# Apply movement
	var movement = speed * direction * delta
	move_and_slide(movement)
	
func death():
	$Animation.material.set_shader_param("whitening", 0.0)
	for i in 5:
		yield(get_tree(), "idle_frame")
		$Animation.material.set_shader_param("red", i / 10.0)
	queue_free()

func take_damage(amount, d):
	if (dead): return
	direction += d
	life = life - amount
	if (life <= 0):
		dead = true
		death()
		return
	
	for i in 4:
		$Animation.material.set_shader_param("whitening", 2.0)
		yield(get_tree(), "idle_frame")
		$Animation.material.set_shader_param("whitening", 0.3)
		yield(get_tree(), "idle_frame")
	$Animation.material.set_shader_param("whitening", 0.0)