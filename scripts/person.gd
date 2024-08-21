extends Area2D

@export var person_name = "Placeholder Name"
var entered = false
var offset: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	%Label.text = person_name
	var string_size = $Label.get_theme_font("font").get_string_size($Label.text, 
		HORIZONTAL_ALIGNMENT_LEFT, -1, $Label.get_theme_font_size("font_size"))
	print(string_size)
	$CollisionShape2D.scale = string_size/10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered && Input.is_action_just_pressed("click"):
		offset = position - get_global_mouse_position()
	if entered && Input.is_action_pressed("click"):
		position = get_global_mouse_position() + offset

#gets called when a person is "renamed"
func _on_label_resized():
	pass


func _on_mouse_entered():
	entered = true


func _on_mouse_exited():
	entered = false
