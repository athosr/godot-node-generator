extends Node2D

# Reduce the node_amount if its laggy
export(int) var node_amount = 20000
export(float) var node_speed = 50

export(Texture) var texture = preload("res://icon.png")

var screen_size

var node_array = []

func _ready():
	randomize()
	screen_size = get_viewport().size

	# Generates the nodes and push them in the array
	for i in node_amount:
		var node = { "position": Vector2(rand_range(0, screen_size.x), 
										 rand_range(0, screen_size.y)),
					"direction": Vector2(rand_range(-1, 1), 
								 		 rand_range(-1, 1)) }
		node_array.push_back(node)

func _process(delta):
	for node in node_array:
		node.position += node.direction * node_speed * delta

	update()
	# You may disable wrap() for a better performance
	wrap()

# Draws the textures based on the position of the nodes
func _draw():
	for node in node_array:
		draw_texture(texture, node.position, Color(randf(), randf(), randf()))

# Keeps the nodes in the viewport area
func wrap():
	for node in node_array:
		if node.position.x >= screen_size.x:
			node.position.x = 0
		elif node.position.x <= 0:
			node.position.x = screen_size.x
			
		if node.position.y >= screen_size.y:
			node.position.y = 0
		elif node.position.y <= 0:
			node.position.y = screen_size.y
