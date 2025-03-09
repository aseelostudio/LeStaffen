class_name Staff
extends Node

signal mana_update(mana)

@export var state : StaffState
@export var max_mana : int = 100
@export var mana : int = 100 :
	get:
		return mana
	set(value):
		mana = value
		mana_update.emit()

@export var character : Character

func _ready():
	mana = max_mana
	_on_state_changed(0)

func _unhandled_input(event: InputEvent) -> void:

	state._manage_input(event)

func _on_state_changed(next_state):
	
	state._on_state_exited()
	state.try_cast_magic.disconnect(check_mana)
	state.change_state.disconnect(_on_state_changed)

	state = get_child(next_state)

	state._on_state_entered()
	state.try_cast_magic.connect(check_mana)
	state.change_state.connect(_on_state_changed)
	Input.set_custom_mouse_cursor(state.icon)

func check_mana():
	if state.mana_cost <= mana:
		if character == null:
			state._cast_magic(Vector2.ZERO)
		else:
			state._cast_magic(character.global_position)
		mana -= state.mana_cost


func _on_mana_recharge_timeout() -> void:
	if mana < max_mana:
		mana += 1
