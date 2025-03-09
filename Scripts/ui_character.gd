extends Control

@export var character : Character
@export var staff : Staff
@export var life_texture : Texture = preload("uid://b2h7rlr4ft1ku")


func _ready():
	
	if not character == null:

		character.health.health_changed.connect(_on_health_changed)

		for i in character.health.max_health_points:
			add_life()

	if not staff == null:
		staff.mana_update.connect(_on_mana_changed)

func _on_health_changed():

	for i in $LifeContainer.get_children():
		i.queue_free()

	for i in character.health.health_points:
		add_life()

func _on_mana_changed():
	$ManaBar.value = staff.mana

func add_life():
	var life = TextureRect.new()
	life.texture = life_texture
	$LifeContainer.add_child(life)

func score_changed(score : int):
	$ScoreLabel.text = "SCORE: " + str(score)
