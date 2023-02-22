extends TextureButton
const PlayerClass = preload("res://player_model/player.gd")
onready var Player = get_tree().get_nodes_in_group("player")[0] as PlayerClass
func _on_button1_pressed():
	if Player.check_for_item("drop_wood",2):
		Player.remove_item("drop_wood",2)
		Player.add_item("build_block",1)
