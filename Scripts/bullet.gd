class_name Bullet
extends Area2D

@export var damage : int = 1

var has_hit : bool = false

func _on_body_entered(body:Node2D) -> void:

	if body is Enemy and !has_hit:
		if not body.health.is_dead:
			body.health.take_damage(damage)
			has_hit = true
	queue_free()
