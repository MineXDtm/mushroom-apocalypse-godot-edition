extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var type = "exit"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_exit_area_entered(area):
	if area.name != "Node2D" and area.name != "exit" and area.name != "exit2" and area.name != "exit3" and area.name != "exit4":
		$CollisionShape2D.disabled = true
