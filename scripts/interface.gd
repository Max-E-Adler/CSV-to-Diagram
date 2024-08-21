extends Node2D

@onready var file = "res://test files/Untitled spreadsheet - Sheet1(2).csv"
const person_scene = preload("res://scenes/person.tscn")
const customer_scene = preload("res://scenes/customer.tscn")
const connector_scene = preload("res://scenes/connector.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_bubble_containers()
	var conn_inst = connector_scene.instantiate()
	conn_inst.customer = %CustomerContainer.get_children()[0]
	conn_inst.person = %PersonContainer.get_children()[0]
	fill_connector_container()
	
func bubble_moving():
	queue_redraw()
	
func connect_bubbles(customer, person):
	var conn_inst = connector_scene.instantiate()
	conn_inst.customer = customer
	conn_inst.person = person
	conn_inst.name = customer.name + " to " + person.name
	%ConnectorContainer.add_child(conn_inst)
	
func fill_connector_container():
	var pm_array = file_to_pm_array(file)

	for pm_psa in pm_array:
		var counter = 0
		var pm_name = ""
		for name in pm_psa:
			if counter > 0:
				var customer = %CustomerContainer.get_node(name)
				var pm = %PersonContainer.get_node(pm_name)
				#connect_bubbles(customer, pm)
				pm.customers.append(customer)
				print("Connecting " + customer.name + " to " + pm.name)
			elif counter == 0:
				pm_name = name
			
			counter += 1

func _draw():
	for pm in %PersonContainer.get_children():
		for cust in pm.customers:
			draw_line(cust.global_position, pm.global_position, Color.BLACK, 3)

func fill_bubble_containers():
	var pm_array = file_to_pm_array(file)
	var customer_names_created: PackedStringArray
	var coord_offset = Vector2(100,100)
	
	#print(pm_array)
	
	for pm_psa in pm_array:
		var counter = 0
		var pm_name
		for name in pm_psa:
			if customer_names_created.has(name):
				break
			if counter == 0: #if we're looking at the first name, aka the pm
				pm_name = name
				var pm = string_and_coords_to_person(name, coord_offset)
				%PersonContainer.add_child(pm)
				pm.connect("is_moving", bubble_moving)
				coord_offset += Vector2(100, 0)
				coord_offset.y = 100
			else: #if we're looking at a customer
				
						
				customer_names_created.append(name)
				#print("Customer: " + name + " doesn't exist in the list!")
				#print("customer_names_created: " + str(customer_names_created))
				var customer = string_and_coords_to_customer(name , coord_offset)
				%CustomerContainer.add_child(customer)
				customer.connect("is_moving", bubble_moving)
				coord_offset += Vector2(0,50)
				#connect_bubbles(%CustomerContainer.get_node(name), %PersonContainer.get_node(pm_name))
				#print(str(%CustomerContainer.get_node(name)) + " 2to " + str(%PersonContainer.get_node(pm_name)))
						
			
			counter += 1

func string_and_coords_to_person(person_input: String, coords: Vector2):
	var person_instance = person_scene.instantiate()
	person_instance.person_name = person_input
	person_instance.global_position = coords
	person_instance.name = person_input
	return person_instance

func string_and_coords_to_customer(person_input: String, coords: Vector2):
	var person_instance = customer_scene.instantiate()
	person_instance.person_name = person_input
	person_instance.global_position = coords
	person_instance.name = person_input
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
