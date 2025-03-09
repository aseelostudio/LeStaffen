class_name StaffState
extends Node2D

signal change_state(next_state)
signal try_cast_magic()

@export var mana_cost : int = 1
@export var icon : Texture = preload("uid://bln3pbrhsibah")

func _on_state_entered():
    pass

func _cast_magic(pos : Vector2):
    pass

func _manage_input(event: InputEvent) -> void:
    pass

func _on_state_exited():
    pass