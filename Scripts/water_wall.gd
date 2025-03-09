class_name WaterWall
extends TileMapLayer

@onready var ray : RayCast2D = $RayCast2D

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_enemy_contact(enemy:Enemy, pos:Vector2) -> void:

	pos = pos - position

	print(local_to_map(pos))
	if get_cell_source_id(local_to_map(pos)) != -1:
		enemy.health.take_damage(1)
		set_cell(local_to_map(pos), -1)
