class_name Player
extends CharacterBody2D

@export var speed : float = 200
@export var animation_tree : AnimationTree

var input : Vector2
var playback : AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]

func _physics_process(_delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	move_and_slide()
	select_animation()
	update_animation_parameters()

func select_animation():
	if velocity == Vector2.ZERO:
		playback.travel("Idle")
	else:
		playback.travel("Walk")

func update_animation_parameters():
	if input == Vector2.ZERO:
		return	
		
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input
	
