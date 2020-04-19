extends KinematicBody2D

# Player movement speed
export var speed = 6000.0
export var orientation = Vector2(1.0, 0.0)

var isPlayer = true

func _ready():
	$Projectile.hide()

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var projectilePosition 
		if orientation.x > 0.1:
			projectilePosition = Vector2(18, - 12)
		else:
			projectilePosition = Vector2(-18, - 12)
		
		var projectile = $Projectile.duplicate()
		projectile.direction = orientation
		projectile.set_position(self.position + projectilePosition)
		self.get_parent().add_child(projectile)
		projectile.show()
		projectile.enable()
		
		$Sound.play()

func _physics_process(delta):
	# Get player input
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	direction = direction.normalized()

	if (direction.length() > 0.1):
		if direction.x > 0.1:
			orientation.x = 1.0
		if direction.x < -0.1:
			orientation.x = -1.0
		
	if (direction.length() > 0.1):
		if orientation.x >= 0:
			$Animation.play('walk')
		else:
			$Animation.play('walkLeft')
	else:
		if orientation.x >= 0:
			$Animation.play('idle')
		else:
			$Animation.play('idleLeft')
	   
	# Apply movement
	var movement = speed * direction * delta
	move_and_slide(movement)
