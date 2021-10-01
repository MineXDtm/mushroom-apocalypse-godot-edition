extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _process(_delta):
#	if get_parent().get_parent().type == "off":
#		disabled = false
#	else:
#		disabled = true





func _on_screen_size_item_selected(index):
	if index == 0:
		 OS.set_window_size(Vector2(1920, 1080))
	elif index == 1:
		OS.set_window_size(Vector2(640, 480))
	elif index == 2:
		 OS.set_window_size(Vector2(1280, 720))
	elif index == 3:
		 OS.set_window_size(Vector2(800, 600))
