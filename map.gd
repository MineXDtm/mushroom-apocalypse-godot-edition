extends Control
var childs = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var point = "1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var names = {
	1:["pchelka"],
	2:["desert"],
}
var point2 = {
	1:["off"],
	2:["off"],
}
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var check = 0
var res =  {
	2:["drop_wood","apple","coal"]
}
var getted = {
	2:[0,0,0]
}
var res_namber = {
	2:[50,99,10]
}
var completed = {
	1:["true"],
	2:["false"],
}
var unlocked = {
	1:["true"],
	2:["true"],
}
func _on_point2_pressed():
	if WorldData.map == "map2":
		get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).opened = false
		visible = false
	elif point != "2" and point2[2][0] == "off":
		for i in point2:
			point2[i][0] = "off"
		point2[2][0] = "on"
		point = "2"
		$list/Label.text = names[int(point)][0]
		$list.visible = true
		for i in range(0,res[int(point)].size()):
			var world = $items
			var drop_scene = load("res://gui/itme_list.tscn")
			var _drop_intance = drop_scene.instance()
			_drop_intance.get_node("ProgressBar").max_value = res_namber[int(point)][i]
			_drop_intance.get_node("ProgressBar").value = getted[2][i]
			_drop_intance.get_node("ProgressBar/Label").text = str(getted[int(point)][i],"/",res_namber[int(point)][i])
			_drop_intance.name = str("item",i)
			_drop_intance.get_node("but").me = i
			_drop_intance.get_node("but").point = point
			_drop_intance.texture = load("res://textures/items/" + res[int(point)][i] + ".png")
			world.add_child(_drop_intance)
	elif point2[int(point)][0] == "on":
		point2[int(point)][0] = "off"
		for i in range(0,res[int(point)].size()):
			var world = $items
			world.get_node(str("item",i)).remove()
		$list.visible = false
		point = "0"

func _process(_delta):
	var points = point
	if points == "1":
		points = ""
	if res.has(int(point)) and WorldData.map != str("map",points):
		for i in range(0,res[int(point)].size()):
			if getted[int(point)][i] == res_namber[int(point)][i]:
				check +=1
		if res[int(point)].size() == check:
			$list/but.disabled = false
			get_node(str("point",point)).texture_normal = load("res://textures/gui/point/point-move.png")
			get_node(str("point",point)).texture_pressed = load("res://textures/gui/point/point-move_clicked.png")
			get_node(str("point",point)).texture_hover = load("res://textures/gui/point/point-move_on_mause.png")
		elif completed[int(point)][0] == "true":
			$list/but.disabled = false
			get_node(str("point",point)).texture_normal = load("res://textures/gui/point/point-move.png")
			get_node(str("point",point)).texture_pressed = load("res://textures/gui/point/point-move_clicked.png")
			get_node(str("point",point)).texture_hover = load("res://textures/gui/point/point-move_on_mause.png")
		else:
			$list/but.disabled = true
		check = 0
	

func _on_point_pressed():
	if WorldData.map == "map":
		get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).opened = false
		visible = false
	elif point != "1" and point2[1][0] == "off":
		for i in point2:
			point2[i][0] = "off"
		if WorldData.map != str("map",2):
			for i in range(0,res[2].size()):
				var world = $items
				world.get_node(str("item",i)).remove()
		point2[1][0] = "on"
		point = "1"
		$list/Label.text = names[int(point)][0]
		$list.visible = true
	elif point2[int(point)][0] == "on":
		point2[int(point)][0] = "off"
		$list.visible = false
		point = "0"
func _on_but_pressed():
	var pointss
	pointss = point
	if point == "1":
		pointss = ""
	for i in unlocked:
		if unlocked[i][0] == "true" and str(i) != point:
			var points
			points = str(i)
			if str(i) == "1":
				points = ""
			get_node(str("point",points)).texture_normal = load("res://textures/gui/point/point-move.png")
			get_node(str("point",points)).texture_pressed = load("res://textures/gui/point/point-move_clicked.png")
			get_node(str("point",points)).texture_hover = load("res://textures/gui/point/point-move_on_mause.png")
	get_node(str("point",pointss)).texture_normal = load("res://textures/gui/point/point-here.png")
	get_node(str("point",pointss)).texture_pressed = load("res://textures/gui/point/point-here_clicked.png")
	get_node(str("point",pointss)).texture_hover = load("res://textures/gui/point/point-here_ON_mause.png")
	$list.visible = false
	if WorldData.map != str("map",2):
		for i in range(0,res[2].size()):
			var world = $items
			world.get_node(str("item",i)).remove()
	get_parent().get_parent().get_node(str(WorldData.map,"/sort/car")).remove(point)
	get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).remove(point)
	if point == "1":
		WorldData.map = "map"
	else:
		WorldData.map = str("map",point)
	visible = false
