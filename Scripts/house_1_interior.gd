extends Node2D

@onready var exit_door_area: Area2D = $ExitDoorArea
var player_in_zone = false

func _ready():
	var player_scene = preload("res://Scenes/player.tscn")
	var player = player_scene.instantiate()
	add_child(player)
	player.position = Global.spawn_position

func _on_exit_door_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in_zone = true

func _on_exit_door_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_zone = false

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("ui_interact"):
		Global.spawn_position = Vector2(251, -175)
		get_tree().change_scene_to_file("res://Scenes/hideout.tscn")
