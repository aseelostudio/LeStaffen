class_name FireState
extends StaffState

@export var bullet_scene : PackedScene = preload("uid://yv087wkwufnx")

var is_casting : bool = false

func _cast_magic(pos):
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.global_position = get_global_mouse_position()
	add_child(bullet)

func _on_state_entered():
	is_casting = false

func _manage_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.is_pressed() and !is_casting:
				is_casting = true
				try_cast_magic.emit()

			elif event.is_released():
				is_casting = false

		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			print("MOUSE DOWN")
			change_state.emit(2)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			change_state.emit(1)

	if event is InputEventMouseMotion and is_casting:
		try_cast_magic.emit()

	
