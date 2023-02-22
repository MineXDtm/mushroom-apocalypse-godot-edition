extends Area2D
var opened = false
var mind = null
var type = "build_block"
onready var healthsystem = get_node("healthsystem")
const MapClass = preload("res://world/map.gd")
onready var map = get_tree().get_nodes_in_group("map")[0] as MapClass
var drops = [["drop_wood",2]]
var  itemdropscene = preload("res://world/drop/ItemDrop.tscn")
func on_dead():
	randomize()
	if (randi()%100) >50:
		for drop in drops:
			var drop_i = itemdropscene.instance()
			drop_i.item_name = drop[0]
			drop_i.count=drop[1]
			get_parent().add_child(drop_i)
			drop_i.position = position
	map.remove_from_slot(position,self)
	queue_free()
func _ready():
	visible = false
	healthsystem.connect("dead",self,"on_dead")
func _on_buildblock_area_entered(area):
	if area.is_in_group("body") :
		
		if opened == false:
			get_parent().get_parent().get_parent().get_node("UI2/builds/menu").visible = true
			get_parent().get_node("player").opened = true
			opened = true
		else:
			get_parent().get_parent().get_parent().get_node("UI2/builds/menu").visible = false
			get_parent().get_node("player").opened = false
			opened = false
			
	


func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
