extends Area2D

@export var time: int = 3

func _ready() -> void:
	$Timer.wait_time = time
	
func _on_body_entered(body: Node2D) -> void:\
	if body is CharacterBody2D:
		$Timer.start

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Timer.stop

func _on_timer_timeout() -> void:
	print("You Died")
