extends Node2D

var player_in_zone = false

func _ready():
	$Player.position = Global.spawn_position

func _on_body_entered(body):
	if body.name == "Player":
		player_in_zone = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("ui_interact"):
		get_tree().change_scene_to_file("res://Scenes/house_1_interior.tscn")
