extends Node2D

@onready var enter_door_area: Area2D = $EnterDoorArea
var player_in_zone = false

func _ready():
	enter_door_area.body_entered.connect(_on_body_entered)
	enter_door_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "player":  # or whatever your player node is named
		player_in_zone = true

func _on_body_exited(body):
	if body.name == "player":
		player_in_zone = false

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("ui_interact"):
		get_tree().change_scene_to_file("res://Scenes/house_1_interior.tscn") 
