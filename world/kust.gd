extends Area2D
var health = 5
const HealthSystemClass = preload("res://systems/healthsystem.tscn")
var layer = 1
var type = "kust"
onready var healthsystem = get_node("healthsystem")

func on_dead():
	queue_free()
	
func _ready():
	healthsystem.connect("dead",self,"on_dead")
	


func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
