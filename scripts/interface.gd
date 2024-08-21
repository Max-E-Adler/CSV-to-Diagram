extends Node2D

@onready var file = "res://test files/first test file.csv"
const person_scene = preload("res://scenes/person.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(file_to_pm_array(file))

func string_to_person(person_input: String):
	var person_instance = person_scene.instantiate()
	person_instance.person_name = person_input
	return person_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func file_to_pm_array(file_input: String):
	var file_string = FileAccess.get_file_as_string(file)
	var words_array = file_string.split("\r\n")
	var pm_array: Array
	var counter = 0
	for str in words_array:
		var delimited = comma_delimited_to_packedstring(str)
		if not delimited.is_empty():
			pm_array.append(delimited)
	return pm_array

func comma_delimited_to_packedstring(comma_delimited: String):
	var psa = comma_delimited.split(",")
	var output: PackedStringArray
	
	for str in psa:
		if str != "":
			output.append(str)
			
	return output
