class_name Writer2D
extends Node2D

signal line_written()

@export var bullet_scene : PackedScene = preload("uid://yv087wkwufnx")
@export var example_line : Line2D

var _is_writing : bool = false
var current_line : Line2D :

	get:
		return current_line

	set(value):

		if value == null:
			_is_writing = false
			if current_line.get_point_count() > -1:
				current_line.queue_free()
			else:
				line_written.emit()
			current_line = value
		
		else:
			_is_writing = true
			current_line = value
			add_child(current_line)
			current_line.name = "Line" + str(get_child_count())

func _ready():
	
	if example_line == null:
		example_line = Line2D.new()
		add_child(example_line)

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.is_pressed() and !_is_writing:
				current_line = example_line.duplicate(true)
				generate_bullet()
				
			elif event.is_released():
				current_line = null

	if event is InputEventMouseMotion and _is_writing:
		current_line.add_point(get_local_mouse_position())
		generate_bullet()

func generate_bullet():
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.global_position = get_global_mouse_position()
	add_child(bullet)
