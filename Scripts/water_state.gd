class_name WaterState
extends StaffState

@export var wall_scene : PackedScene = preload("uid://dngatwnvre8ol")

func _cast_magic(pos):
	var wall : WaterWall = wall_scene.instantiate()
	wall.global_position = pos
	add_child(wall)

func _on_state_entered():
	pass

func _manage_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.is_released():
				try_cast_magic.emit()
	
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			change_state.emit(0)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			change_state.emit(2)
	
