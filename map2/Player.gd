extends KinematicBody2D

# Player movement speed
export var speed = 5000.0

func _ready():
	$Projectile.hide()

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var projectile = $Projectile.duplicate()
		projectile.set_position(Vector2(self.position.x + 18, self.position.y - 12))
		self.get_parent().add_child(projectile)
		projectile.show()
		projectile.enable()

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
		
	if (direction.length() > 0.1):
		$Animation.play('walk')
	else:
		$Animation.play('idle')
	   
	# Apply movement
	var movement = speed * direction * delta
	move_and_slide(movement)
