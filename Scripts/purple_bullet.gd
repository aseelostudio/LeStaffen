class_name PurpleBullet
extends Area2D

@export var damage : int = 1
@export var speed : float = 30.

var velocity : Vector2

func _physics_process(delta: float) -> void:
	position += velocity * speed * delta

func _on_body_entered(body:Node2D) -> void:
	
	if body is Enemy:
		body.health.take_damage(1)
	else:
		queue_free()
        
