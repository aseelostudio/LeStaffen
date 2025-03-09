class_name PurpleState
extends StaffState

@export var purple_bullet : PackedScene = preload("uid://bwo2iy3gr0810")

func _cast_magic(pos):
	var bullet : PurpleBullet = purple_bullet.instantiate()
	bullet.global_position = pos
	bullet.velocity = (get_global_mouse_position() - pos).normalized()
	add_child(bullet)

func _on_state_entered():
	pass


func _manage_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.is_released():
				try_cast_magic.emit()
    
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			change_state.emit(1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			change_state.emit(0)
	