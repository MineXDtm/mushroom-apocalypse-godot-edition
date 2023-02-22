extends TextureButton
const PlayerClass = preload("res://player_model/player.gd")
onready var Player = get_tree().get_nodes_in_group("player")[0] as PlayerClass
func _on_button2_pressed():
	if Player.check_for_item("cobblestone",12):
		Player.remove_item("cobblestone",12)
		Player.add_item("stove",1)

