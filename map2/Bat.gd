extends KinematicBody2D

# Player movement speed
export var speed = 5000.0
var direction: Vector2 = Vector2(0.0, 0.0)
var life = 50

func _physics_process(delta):
	# Get player input
	direction.x += (randf() - 0.5)
	direction.y += (randf() - 0.5)
	
	direction = direction.normalized()
	
	# Apply movement
	var movement = speed * direction * delta
	move_and_slide(movement)
	
func take_damage(amount):
	life = life - amount
	if (life <= 0):
		self.get_parent().remove_child(self)