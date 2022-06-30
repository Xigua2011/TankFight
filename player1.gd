extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 10
export var PLAYER = "1"
var bullet = preload("res://bullet.tscn")
var explosion = preload("res://explosion.tscn")
var score1 = 0
var score2 = 0
onready var score_label2 = get_node("../score2")
onready var score_label1 = get_node("../score1")
export var MAX_X = 400
export var MIN_X = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$power.value = timer
	if Input.is_action_pressed ("fire"+PLAYER):
		timer += delta
	if Input.is_action_pressed("Up"+PLAYER):
		#position.y += -speed
		$turret.rotation += 0.03
	if Input.is_action_pressed("Down"+PLAYER):
		#position.y += speed
		$turret.rotation -= 0.03
	if Input.is_action_pressed("Left"+PLAYER):
		position.x += -speed
	if Input.is_action_pressed("Right"+PLAYER):
		position.x += speed
	if Input.is_action_just_released("fire"+PLAYER):
		var b = bullet.instance()
		b.position = $turret/turret/fire_point.global_position
		b.rotation = -$turret.rotation
		print($turret.rotation_degrees)
		#print(int(rotation_degrees) % 360)
		var yvel = sin($turret.rotation) * 7
		var xvel = cos($turret.rotation) * -7
		b.speed = Vector2(xvel, yvel) * timer
		#if PLAYER == "2":
		b.speed = -b.speed
		get_tree().root.add_child(b)
		timer = 0
	if position.x < MIN_X:
		position.x = MIN_X
	if position.x > MAX_X:
		position.x = MAX_X
		


func _on_player2_area_entered(area):
	print("player 2 hit")
	$oof.play()
#	var e = explosion.instance()
#	e.position = global_position
#	get_tree().root.add_child(e)
	score1 += 1
	score_label1.text = str(score1)

func _on_player1_area_entered(area):
	print("player 1 hit")
	$oof.play()
#	var e = explosion.instance()
#	e.position = global_position
#	get_tree().root.add_child(e)
	score2 += 1
	score_label2.text = str(score2)
