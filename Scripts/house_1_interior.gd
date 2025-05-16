extends Node2D

#@onready var exit_door_area: Area2D = $ExitDoorArea
@export var target_scene: String = "res://Scenes/hideout.tscn"
@export var spawn_position_in_new_scene: Vector2 = Vector2(8, -8)

var player_in_zone = false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "player":
		player_in_zone = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_zone = false

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("ui_interact"):
		Global.spawn_position = spawn_position_in_new_scene
		get_tree().change_scene_to_file(target_scene) 
