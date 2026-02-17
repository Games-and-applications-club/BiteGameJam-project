extends CanvasLayer

var heart_list: Array[TextureRect] = []
var health: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hearts_parent = $HBoxContainer
	for child in hearts_parent.get_children():
		heart_list.append(child)

		
func update_heart_display():
	for i in range(heart_list.size()):
		heart_list[i].visible = i < health


func _on_button_pressed() -> void:
	if health > 0:
		health -= 1
	update_heart_display()


func _on_button_2_pressed() -> void:
	health += 1
	update_heart_display()
