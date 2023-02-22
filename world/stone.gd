extends Area2D

var type = "stone"
onready var healthsystem = get_node("healthsystem")
const MapClass = preload("res://world/map.gd")
onready var map = get_tree().get_nodes_in_group("map")[0] as MapClass
var drops = [["cobblestone",1]]
var  itemdropscene = preload("res://world/drop/ItemDrop.tscn")
func on_dead():
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





func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
