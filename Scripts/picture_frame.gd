# PictureFrame.gd
@tool
extends Node2D

@onready var Photo: Sprite2D = $Photo

@export var photo_texture: Texture2D:
	set(value):
		photo_texture = value
		update_texture()

func _ready():
	update_texture()
	if photo_texture:
		Photo.texture = photo_texture
		
func update_texture():
	if Photo and photo_texture:
		Photo.texture = photo_texture
