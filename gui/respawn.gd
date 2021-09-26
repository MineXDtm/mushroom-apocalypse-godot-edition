extends Button

var random_x
var random_y
var cords 
func _on_Button_pressed():
	get_tree().paused = false
	cords = get_parent().get_parent().get_parent().get_node("map/zombies").cords
	randomize()
	for i in range(randi() % cords.size()):
		random_x = cords[i]
	for i in range(randi() % cords.size()):
		random_y = cords[i]
	var random_pos = Vector2(random_x,random_y)
	get_node(str("/root/world/",WorldData.map,"/sort/player")).position = random_pos
	get_node(str("/root/world/",WorldData.map,"/sort/player")).visible = true
	get_node(str("/root/world/",WorldData.map,"/sort/player")).health = 20
	get_node(str("/root/world/",WorldData.map,"/sort/player")).died = false
	get_parent().visible = false
