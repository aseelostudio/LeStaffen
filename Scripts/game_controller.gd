extends Node

var main_path : String = "uid://d3n22vrorcuch"
var main : Main
var high_score : int = 0

func start_game():
    $MenuUI.visible = false
    main = (load(main_path) as PackedScene).instantiate()
    add_child(main)
    move_child(main, 0)

    main.match_end.connect(end_game)

func end_game():
    if main.score > high_score:
        high_score = main.score
    $MenuUI/Menu/MarginContainer/VBoxContainer2/Label.text = "BEST SCORE: " + str(high_score)
    $MenuUI.visible = true
    main.queue_free()