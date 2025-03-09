class_name Spawner
extends Path2D

signal queue_enemy(enemy)

@export var enemies : Array[PackedScene] = [preload("uid://dxws4ch22piqp")]
@export var speed : float = 1

@onready var spawn_point : PathFollow2D = $SpawnPoint


func _process(delta):
	spawn_point.progress_ratio += delta * speed

func _on_spawn_timer_timeout() -> void:
	$SpawnTimer.wait_time -= 0.01 * $SpawnTimer.wait_time
	var enemy : Enemy = enemies[0].instantiate()
	enemy.global_position = spawn_point.global_position
	queue_enemy.emit(enemy)
