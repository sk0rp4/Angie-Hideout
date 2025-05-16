extends Area2D

@export var target_scene: String = "res://Scenes/museum_interior.tscn"
@export var spawn_position_in_new_scene: Vector2 = Vector2.ZERO

var player_in_area = false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_area = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("ui_interact"):
		Global.spawn_position = spawn_position_in_new_scene
		get_tree().change_scene_to_file(target_scene)
