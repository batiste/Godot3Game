extends Area2D

# Player movement speed
export var speed = 150.0
export var direction = Vector2(1.0, 0.0)

func _ready():
	print('ready')
	self.set_process(false)
	self.set_process_internal(false)
	self.set_physics_process(false)
	
func enable():
	self.set_process(true)
	self.set_process_internal(true)
	self.set_physics_process(true)
	connect("body_entered", self, "_on_enemy_body_enter")
	self.rotation = direction.angle()

func _on_enemy_body_enter(body):
	print('collision with', body)
	if(body.has_method('take_damage')):
		body.take_damage(2, speed * direction)
	$Sound.play()
#	self.hide()
	self.set_physics_process(false)
	var timer = Timer.new()
	timer.connect("timeout", self,"_destroy")
	add_child(timer) #to process
	timer.start(2.0) #to start
	$CPUParticles2D.gravity = Vector2(0.0, 0.0)
	
func _destroy():
	var parent: Node = self.get_parent()
	parent.remove_child(self)

func _physics_process(delta):
	var movement = speed * direction * delta
	self.position += movement
	
