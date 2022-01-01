extends Node2D
var childs = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var point = "1"

# Called when the node enters the scene tree for the first time.

var names = {
	1:"forrest",
	2:"desert",
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
	1:[],
	2:["drop_wood","apple","coal"]
}
var getted = {
	1:[0,0,0],
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
func _ready():
	var buts = get_node("buttons").get_children()
	for i in buts:
		i.connect("pressed",self,"_on_point_pressed")
		i.index = str(int(i.name))
		i.connect("pressed",i,"clicked")

func _on_point_pressed():
	yield(get_tree().create_timer(0.01), "timeout")
	if WorldData.world_type == names[int(point)] :
		get_parent().get_parent().get_parent().get_parent().get_parent().get_node(str(WorldData.map,"/sort/player")).opened = false
		get_parent().get_parent().get_parent().visible = false
		get_parent().gui_disable_input = true
		return
	elif point2[int(point)][0] == "off":
		for i in point2:
			point2[i][0] = "off"
		point2[int(point)][0] = "on"
		$CanvasLayer/list/Label.text = names[int(point)]
		$CanvasLayer/list.visible = true
		var worlds = $CanvasLayer/list/items.get_children()
		for i in worlds:
			i.remove()
		for i in range(0,res[int(point)].size()):
			var world = $CanvasLayer/list/items
			var drop_scene = load("res://gui/itme_list.tscn")
			var _drop_intance = drop_scene.instance()
			_drop_intance.get_node("ProgressBar").max_value = res_namber[int(point)][i]
			_drop_intance.get_node("ProgressBar").value = getted[2][i]
			_drop_intance.get_node("ProgressBar/Label").text = str(getted[int(point)][i],"/",res_namber[int(point)][i])
			_drop_intance.name = str("item",i)
			_drop_intance.get_node("but").me = i
			_drop_intance.get_node("but").point = point
			_drop_intance.get_node("TextureRect").texture = load("res://textures/items/" + res[int(point)][i] + ".png")
			world.add_child(_drop_intance)
	elif point2[int(point)][0] == "on":
		point2[int(point)][0] = "off"
		for i in range(0,res[int(point)].size()):
			var world = $CanvasLayer/list/items
			world.get_node(str("item",i)).remove()
		$CanvasLayer/list.visible = false
		point = "0"

func _process(_delta):
	var points = point
	if res.has(int(point)) and WorldData.map != str("map",points):
		for i in range(0,res[int(point)].size()):
			if getted[int(point)][i] == res_namber[int(point)][i]:
				check +=1
		if res[int(point)].size() == check:
			$CanvasLayer/list/but.disabled = false
			get_node(str("buttons/point",point)).texture_normal = load("res://textures/gui/point/point-move.png")
			get_node(str("buttons/point",point)).texture_pressed = load("res://textures/gui/point/point-move_clicked.png")
			get_node(str("buttons/point",point)).texture_hover = load("res://textures/gui/point/point-move_on_mause.png")
		elif completed[int(point)][0] == "true":
			$CanvasLayer/list/but.disabled = false
			get_node(str("buttons/point",point)).texture_normal = load("res://textures/gui/point/point-move.png")
			get_node(str("buttons/point",point)).texture_pressed = load("res://textures/gui/point/point-move_clicked.png")
			get_node(str("buttons/point",point)).texture_hover = load("res://textures/gui/point/point-move_on_mause.png")
		else:
			$CanvasLayer/list/but.disabled = true
		if WorldData.world_type == names[int(point)] :
			get_node(str("buttons/point",point)).texture_normal = load("res://textures/gui/point/point-here.png")
			get_node(str("buttons/point",point)).texture_pressed = load("res://textures/gui/point/point-here_clicked.png")
			get_node(str("buttons/point",point)).texture_hover = load("res://textures/gui/point/point-here_ON_mause.png")
		check = 0
	


func _on_but_pressed():
	var pointss
	pointss = point
	var worlds = $CanvasLayer/list/items.get_children()
	for i in worlds:
		i.remove()
	for i in unlocked:
		if unlocked[i][0] == "true" and str(i) != point:
			var points
			points = str(i)
			get_node(str("buttons/point",points)).texture_normal = load("res://textures/gui/point/point-move.png")
			get_node(str("buttons/point",points)).texture_pressed = load("res://textures/gui/point/point-move_clicked.png")
			get_node(str("buttons/point",points)).texture_hover = load("res://textures/gui/point/point-move_on_mause.png")
	get_node(str("buttons/point",pointss)).texture_normal = load("res://textures/gui/point/point-here.png")
	get_node(str("buttons/point",pointss)).texture_pressed = load("res://textures/gui/point/point-here_clicked.png")
	get_node(str("buttons/point",pointss)).texture_hover = load("res://textures/gui/point/point-here_ON_mause.png")
	$CanvasLayer/list.visible = false
	WorldData.world_type = names[int(pointss)]
	yield(get_tree(), 'idle_frame')
	get_parent().get_parent().get_node(WorldData.map).change_biome()
	get_parent().get_parent().get_node(WorldData.map+"/sort/player").opened = false
	visible = false
