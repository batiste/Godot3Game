extends Node2D

const HEIGHT = 100
const WIDTH = 100

func _ready():
	get_viewport().connect("size_changed", self, "window_resize")
	randomize()
	var simplex = OpenSimplexNoise.new()
	simplex.seed = randi()
	
	simplex.octaves = 3
	simplex.period = 20
	simplex.lacunarity = 2
	#simplex.persistence = 0.75
	
	for x in WIDTH:
		for y in HEIGHT:
			var vect = Vector2(x - HEIGHT / 2, y - WIDTH / 2)
			var value = simplex.get_noise_2d(float(x), float(y))
			var index = _tile_index(value)
			$TileMap.set_cellv(vect, index)
	$TileMap.update_bitmask_region()
	$TileMap.update()
	
func window_resize():
    get_viewport().set_size_override(true, OS.get_window_size())

func _tile_index(v):
	# water
	# if v < -0.40:
	#	return 3
	if v < -0.25:
		return 1
	if v < 0.4:
		return 2
	else:
		return 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
