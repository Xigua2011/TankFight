extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = Vector2(10,-5)
var gravity = Vector2(0, 0.1)
var explosion = preload("res://explosion.tscn")

onready var map = get_node("/root/tankfight/TileMap")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#position += speed * 9
	#'if speed.x < 0:
	#	scale.x = -0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed += gravity
	position += speed


func _on_bullet_body_entered(body):
	print("bullet body entered ", body)
	var e = explosion.instance()
	e.position = position
	get_tree().root.add_child(e)
	queue_free()





func _on_bullet_body_shape_entered(body_rid, _body, body_shape, local_shape):
	var coordinate: Vector2 = Physics2DServer.body_get_shape_metadata(body_rid, body_shape)
	print(coordinate)
	print(map)
	map.set_cellv(coordinate, -1)
