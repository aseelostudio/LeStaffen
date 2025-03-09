class_name Enemy
extends CharacterBody2D

static var character : Character

@export var speed : float = 1.
@export var damage : int = 1
@export var recoil : float = 20.

@onready var health := $HealthManager
@onready var timer : Timer = $KnockbackTimer

var next_velocity : Vector2 = Vector2.ZERO

var knockback : bool = false

func _physics_process(_delta: float) -> void:

	if not character == null:

		if knockback:
			velocity = -(character.global_position - global_position) * recoil
		else:
			velocity = (character.global_position - global_position) * speed
	
	move_and_slide()

func _on_death():
	queue_free()


func _on_area_2d_body_entered(body:Node2D) -> void:
	
	if body is Character:
		body.health.take_damage(damage)
		on_knockback()



func _on_knockback_timer_timeout() -> void:
	knockback = false

func on_knockback():
	knockback = true
	timer.start()
