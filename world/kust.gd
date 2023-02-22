extends Area2D
var health = 5
const HealthSystemClass = preload("res://systems/healthsystem.tscn")
const MapClass = preload("res://world/map.gd")
onready var map = get_tree().get_nodes_in_group("map")[0] as MapClass
var layer = 1
var type = "kust"
onready var healthsystem = get_node("healthsystem")
var drops = [["drop_wood",1]]
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
	healthsystem.connect("dead",self,"on_dead")



func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
