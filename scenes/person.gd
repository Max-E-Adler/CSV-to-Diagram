extends Area2D

@export var person_name = "Placeholder Name"

# Called when the node enters the scene tree for the first time.
func _ready():
	%Label.text = person_name
	var string_size = $Label.get_theme_font("font").get_string_size($Label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, $Label.get_theme_font_size("font_size"))
	print(string_size)
	$CollisionShape2D.scale = string_size/10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#gets called when a person is "renamed"
func _on_label_resized():
	pass
