extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(_delta):
	if get_parent().selected == 3:
		get_parent().get_node("builds").visible = true
		disabled = true
	else:
		get_parent().get_node("builds").visible = false
		disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_menu_button3_pressed():
	get_parent().selected = 3
