class_name WaterWall
extends TileMapLayer

@onready var ray : RayCast2D = $RayCast2D

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_wall_area_body_entered(body:Node2D) -> void:

	var coll_pos

	if body is Enemy:
		ray.enabled = true
		ray.target_position = to_local(body.global_position)
		ray.force_raycast_update()

		while ray.is_colliding():
			if ray.get_collider() is Enemy:
				if ray.get_collider() == body:
					coll_pos = ray.get_collision_point()
					break
			ray.add_exception(ray.get_collider())
			ray.force_raycast_update()
		
		ray.clear_exceptions()
		ray.enabled = false
		
		body.health.take_damage(1)
		set_cell(local_to_map(coll_pos), -1)
