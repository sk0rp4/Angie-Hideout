extends Node

var spawn_position: Vector2 = Vector2(0, 0)

var museum_textures: Array[Texture2D] = []

func _ready():
	museum_textures = [
		preload("res://Assets/Photos hideout hommage/Milestones/1.png"),
		preload("res://Assets/Photos hideout hommage/Milestones/2.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/3.png"),
		preload("res://Assets/Photos hideout hommage/Milestones/4.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/5.png"),
		preload("res://Assets/Photos hideout hommage/Milestones/6.png"),
		preload("res://Assets/Photos hideout hommage/Milestones/7.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/8.png"),
		preload("res://Assets/Photos hideout hommage/Milestones/9.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/10.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/11.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/12.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/13.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/14.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/15.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/16.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/17.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/18.jpg"),
		preload("res://Assets/Photos hideout hommage/Milestones/trip.png"),
	]
