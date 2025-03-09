class_name HealthManager
extends Node

signal damage_taken()
signal death()
signal health_changed()
signal invincibility_changed()

var timer : Timer
var is_dead : bool = false

@export var max_health_points : int

var health_points : int :
	get:
		return health_points
	set(value):

		if value < health_points:
			
			if is_invincible:
				return
			
			if value < 0:
				health_points = 0
				is_dead = true
				death.emit()
			else:
				health_points = value
				damage_taken.emit()
				is_invincible = true
		else:

			if(value > max_health_points):
				health_points = max_health_points
			else:
				health_points = value
		
		health_changed.emit()

var is_invincible : bool :
	get:
		return is_invincible
	set(value):
		if value == true:
			timer.start()
		else:
			timer.stop()
		is_invincible = value
		invincibility_changed.emit()


func _ready():
	timer = Timer.new()
	{
		wait_time = 0.3,
		autostart = false,
		one_shot = true
	}
	add_child(timer)
	timer.timeout.connect(func():
		is_invincible = false)
	replenish()

func replenish():
	health_points = max_health_points

func take_damage(damage : int):
	health_points -= damage
