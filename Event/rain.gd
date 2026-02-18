extends GPUParticles2D

@onready var player = null

@onready var warning: TextureRect= $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	warning.modulate.a = 0.0
	self.visibility_rect = Rect2(Vector2(-2000, -2000), Vector2(4000, 12000))
	self.process_material.color.a = 0.0

func fade(target_alpha: float, duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(warning, "modulate:a", target_alpha, duration)
	return tween

func _on_area_2d_body_exited(body: Node2D) -> void:
	$Timer.stop()
	$Timer2.stop()
	self.process_material.color.a = 0.0
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player = body
		$Timer2.start()

func _on_timer_2_timeout() -> void:
	for i in range(3):
		await fade(1.0, 0.5).finished
		await fade(0.0, 0.5).finished
	self.process_material.color.a = 1.0
	$Timer3.start()
	player.hpSystem.take_damage()

func _on_timer_3_timeout() -> void:
	$Timer3.start()
	player.hpSystem.take_damage()
