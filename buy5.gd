extends TextureButton
var nedded1 = null
var nedded2 = null
var done
var done_number
var needed_number1
var needed_number2
const PlayerClass = preload("res://player_model/player.gd")
onready var Player = get_tree().get_nodes_in_group("player")[0] as PlayerClass

func _on_buy_pressed():
	Console.write_line(needed_number1)
	if nedded2 != null and not Player.check_for_item(nedded2 ,needed_number2 ):return
	Console.write_line("test")
	if nedded1 != null and not Player.check_for_item(nedded1 ,needed_number1):return
	if nedded1 != null:  Player.remove_item(nedded1,needed_number1)
	if nedded2 != null:  Player.remove_item(nedded2,needed_number2)
	Player.add_item(done,done_number)
