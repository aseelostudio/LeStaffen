class_name Bullet
extends Area2D

@export var damage : int = 1


func _on_body_entered(body:Node2D) -> void:

	if body is Enemy:
		body.health.take_damage(damage)

	queue_free()
