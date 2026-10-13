extends TileMap

@export var max_x: int = 200 # max pixel width in noise texture
@export var max_y: int = 200 # max pixel height in noise texture

var noise : FastNoiseLite = FastNoiseLite.new()
var snap_size_x = 18 # size of the blocks in x axis
var snap_size_y = 18 # size of the blocks in y axis

func _ready() -> void:
	randomize()
	noise.seed = randi() # chooses random unsigned 32-bit integer
	# for the seed so the seed will never be the same twice
	noise.frequency = 1.0
	noise.octaves = 1
	noise.gain = 1.0
	noise.lacunarity = 2.43

	generateLevel()

func generateLevel():
	for x in range(max_x): # loops through x values
		for y in range(max_y): # loops through y values
			if y < (max_y / 2) and x < (max_x / 2):
				var tileID = generate_id(noise.get_noise_2d(x,y)) # generates the strength of the pixel
				if(tileID != -1):
					set_cell(0, Vector2i(x, y), tileID) # sets cell to be a block or empty space
			elif y >= (max_y / 2) and x <= (max_x / 2):
				var tileID = generate_id(noise.get_noise_2d(x,y))  
				if(tileID != -1):
					set_cell(0, Vector2i(x, y), tileID+2)  
			elif y <= (max_y / 2) and x >= (max_x / 2):
				var tileID = generate_id(noise.get_noise_2d(x,y))  
				if(tileID != -1):
					set_cell(0, Vector2i(x, y), tileID+3)  
			elif y >= (max_y / 2) and x >= (max_x / 2):
				var tileID = generate_id(noise.get_noise_2d(x,y))  
				if(tileID != -1):
					set_cell(0, Vector2i(x, y), tileID+4)  

func generate_id(noise_level: float):
	if noise_level <= -0.01:
		return -1
	elif noise_level <= 0.01:
		return 0
	else:
		return 1
