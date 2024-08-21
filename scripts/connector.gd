extends Node2D

var customer
var person

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#connect("redraw_line", redraw_line_time())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if customer && person:
		pass
		#queue_redraw()

func _draw():
	draw_line(customer.global_position, person.global_position, Color.BLACK, 3)

func redraw_line_time():
	queue_redraw()
