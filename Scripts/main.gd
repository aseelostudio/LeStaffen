class_name Main
extends Node

signal match_end()

@export var character : Character

var score : int = 0 :
	get:
		return score
	set(value):
		score = value
		$UILayer/UI/Character.score_changed(score)

func _ready():
	Enemy.character = character
	character.character_death.connect(_on_character_death)
	$World/SpawnerPath.queue_enemy.connect(_on_queue_enemy)

	$UILayer/UI/Character/PauseMenu/MarginContainer/VBoxContainer/ResumeButton.button_up.connect(resume_game)
	$UILayer/UI/Character/PauseMenu/MarginContainer/VBoxContainer/QuitButton.button_up.connect(end_match)

func _on_queue_enemy(enemy : Enemy):
	$World/Enemies.add_child(enemy)
	enemy.enemy_death.connect(_on_enemy_death)

func _on_enemy_death(enemy):
	score += enemy.value

func _on_character_death():
	end_match()

func end_match():
	resume_game()
	match_end.emit()

func pause_game():
	get_tree().paused = true
	$UILayer/UI/Character/PauseMenu.visible = true

func resume_game():
	get_tree().paused = false
	$UILayer/UI/Character/PauseMenu.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE and event.is_released():
			pause_game()
