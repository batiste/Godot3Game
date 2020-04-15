extends KinematicBody2D

# Player movement speed
export var speed = 5000.0
var direction: Vector2 = Vector2(0.0, 0.0)
var life = 50
var dead = false

func _physics_process(delta):
	# Get player input
	direction.x += (randf() - 0.5)
	direction.y += (randf() - 0.5)
	
	direction = direction.normalized()
	
	# Apply movement
	var movement = speed * direction * delta
	move_and_slide(movement)
	
func death(amount):
	$Animation.material.set_shader_param("whitening", 0.0)
	for i in 10:
		$Animation.material.set_shader_param("red", i / 10.0)
	self.get_parent().remove_child(self)

func take_damage(amount, d):
	direction += d
	life = life - amount
	if (life <= 0):
		dead = true
		queue_free()
		return
	
	for i in 4:
		$Animation.material.set_shader_param("whitening", 2.0)
		yield(get_tree(), "idle_frame")
		$Animation.material.set_shader_param("whitening", 0.3)
		yield(get_tree(), "idle_frame")
	$Animation.material.set_shader_param("whitening", 0.0)