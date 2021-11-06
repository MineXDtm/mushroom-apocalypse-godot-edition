extends TextureRect
var selected = 1
var instrements = {
	"wooden_exe":[1,"drop_wood",3],
	"wooden_pickaxe":[1,"drop_wood",2],
	"stone_exe":[1,"drop_wood",1,"cobblestone",3],
	"stone_pickaxe":[1,"drop_wood",1,"cobblestone",2],
}
var farm = {
	"kust_fruit_in_pot":[1,"apple",1],
}
var builds = {
	"block_beta":[1,"drop_wood",1],
	"stone_block":[1,"cobblestone",4],
	"wooden_floor":[1,"drop_wood",2],
	"door":[1,"drop_wood",2],
}
var drops = {
	"coal":[1,"drop_wood",2,"cobblestone",1],
	"torch":[1,"drop_wood",1,"coal",1],
}
var mechanisms = {
	"wooden_trap":[1,"drop_wood",3,"iron",1],
}

func _ready():
	for i in $GridContainer.get_children():
		i.connect("pressed", self, "reload_category",[i])
	var button = load("res://gui/menubut.tscn")
	var category = instrements
	for i in category:
		var button_instance = button.instance()
		button_instance.get_node("done/Label").text = str(category[i][0])
		if category[i][0] == 1:
			button_instance.get_node("done/Label").visible = false
		button_instance.get_node("done").texture = load("res://textures/items/" + i + ".png")
		if category[i].size() == 3:
			button_instance.get_node("need2/Label").text =  str(category[i][2])
			button_instance.get_node("need").texture = load("res://textures/items/" + category[i][1] + ".png")
			button_instance.nedded2 = category[i][1]
			button_instance.needed_number2 = category[i][2]
			button_instance.done = i
			button_instance.done_number = category[i][0]
			if category[i][2] == 1:
				button_instance.get_node("need2/Label").visible = false
			button_instance.get_node("need").visible = false
		else:
			button_instance.nedded2 = category[i][1]
			button_instance.needed_number2 = category[i][2]
			button_instance.done = i
			button_instance.done_number = category[i][0]
			button_instance.nedded1 = category[i][3]
			button_instance.needed_number1 = category[i][4]
			button_instance.get_node("need2/Label").text =  str(category[i][2])
			button_instance.get_node("need2").texture = load("res://textures/items/" + category[i][1] + ".png")
			if category[i][2] == 1:
				button_instance.get_node("need2/Label").visible = false
			button_instance.get_node("need/Label").text =  str(category[i][4])
			button_instance.get_node("need").texture = load("res://textures/items/" + category[i][3] + ".png")
			if category[i][4] == 1:
				button_instance.get_node("need/Label").visible = false
		get_node("crafts/VBoxContainer").add_child(button_instance)
	var end = load("res://gui/end.tscn")
	var ended = end.instance()
	get_node("crafts/VBoxContainer").add_child(ended)
func reload_category(target):
	var category = get(target.get_name())
	for i in $crafts/VBoxContainer.get_children():
		i.queue_free()
	var button = load("res://gui/menubut.tscn")
	for i in category:
		var button_instance = button.instance()
		button_instance.get_node("done/Label").text = str(category[i][0])
		if category[i][0] == 1:
			button_instance.get_node("done/Label").visible = false
		button_instance.get_node("done").texture = load("res://textures/items/" + i + ".png")
		if category[i].size() == 3:
			button_instance.get_node("need2/Label").text =  str(category[i][2])
			button_instance.get_node("need2").texture = load("res://textures/items/" + category[i][1] + ".png")
			button_instance.nedded2 = category[i][1]
			button_instance.needed_number2 = category[i][2]
			button_instance.done = i
			button_instance.done_number = category[i][0]
			if category[i][2] == 1:
				button_instance.get_node("need2/Label").visible = false
			button_instance.get_node("need").visible = false
		else:
			button_instance.nedded2 = category[i][1]
			button_instance.needed_number2 = category[i][2]
			button_instance.done = i
			button_instance.done_number = category[i][0]
			button_instance.nedded1 = category[i][3]
			button_instance.needed_number1 = category[i][4]
			button_instance.get_node("need2/Label").text =  str(category[i][2])
			button_instance.get_node("need2").texture = load("res://textures/items/" + category[i][1] + ".png")
			if category[i][2] == 1:
				button_instance.get_node("need2/Label").visible = false
			button_instance.get_node("need/Label").text =  str(category[i][4])
			button_instance.get_node("need").texture = load("res://textures/items/" + category[i][3] + ".png")
			if category[i][4] == 1:
				button_instance.get_node("need/Label").visible = false
		get_node("crafts/VBoxContainer").add_child(button_instance)
	var end = load("res://gui/end.tscn")
	var ended = end.instance()
	get_node("crafts/VBoxContainer").add_child(ended)
