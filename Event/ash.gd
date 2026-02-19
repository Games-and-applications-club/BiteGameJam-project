extends Area2D

@export var time: int = 3

@onready var player = null
var damaging := false

func _ready() -> void:
	$Timer.wait_time = time
	
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not damaging:
		player = body
		damaging = true
		$Timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Timer.stop()
		player = null
		damaging = false

func _on_timer_timeout() -> void:
	if player != null:
		player.hpSystem.take_damage()
		$Timer.start()
