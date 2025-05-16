extends Area2D

@export var player_path: NodePath
@export var destination_path: NodePath

var player_in_area = false

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "player": # Adjust if your player is named differently
		player_in_area = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_area = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("ui_interact"): # define "interact" in input map as F
		var player = get_node(player_path)
		var dest = get_node(destination_path)
		player.global_position = dest.global_position
