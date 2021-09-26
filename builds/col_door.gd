extends CollisionShape2D
var cooldown = false
func _process(_delta):
	if cooldown == false:
		cooldown = true
		get_parent().get_node("Timer").start()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if disabled == true:
		disabled = false
	else:
		disabled = true
	cooldown = false
