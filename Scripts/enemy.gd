class_name Enemy
extends CharacterBody2D

static var character : Character

signal enemy_death(enemy)

@export var speed : float = 1.
@export var damage : int = 1
@export var recoil : float = 20.
@export var value : int = 1

@onready var health := $HealthManager
@onready var timer : Timer = $KnockbackTimer

var next_velocity : Vector2 = Vector2.ZERO

var knockback : bool = false

func _physics_process(_delta: float) -> void:

	if not character == null:

		if knockback:
			velocity = -(character.global_position - global_position) * recoil
		else:
			velocity = (character.global_position - global_position).normalized() * speed
	
	"""for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print(collider)
		if collider is WaterWall:
			var tile_pos = collider.world_to_map(position)  # character's position
			tile_pos -= collision.normal  # colliding tile position
			collider.set_cellv(tile_pos, -1)
"""
	move_and_slide()

func _on_death():
	enemy_death.emit(self)
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
