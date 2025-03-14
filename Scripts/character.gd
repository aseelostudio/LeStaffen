class_name Character
extends CharacterBody2D

signal character_death()

@export var camera : Camera2D
@export var speed : float

@onready var health : HealthManager = $HealthManager

var target_position : Vector2
var can_move : bool = true

func _ready():

	target_position = position

	if not camera == null:
		$RemoteTransform2D.remote_path = camera.get_path()

	health.death.connect(_on_death)
	health.invincibility_changed.connect(_on_invincibility_changed)

func _physics_process(_delta: float) -> void:

	if can_move:
		velocity = (target_position - global_position) * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		match event.button_index:
			
			MOUSE_BUTTON_RIGHT:
				if event.is_released():
					target_position = get_global_mouse_position()

func _on_death():
	can_move = false
	visible = false
	$RemoteTransform2D.remote_path = ""
	character_death.emit()

func _on_invincibility_changed():
	if health.is_invincible:
		modulate = Color.RED
	else:
		modulate = Color.WHITE

class State:
	var i = 0
