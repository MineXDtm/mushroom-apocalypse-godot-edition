extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal skinloaded(skin)

# Called when the node enters the scene tree for the first time.
var skin
func loadskin(skinpath):
	var texture = ImageTexture.new()
	texture.create_from_image(skinpath, 0)
	skin = texture;
	emit_signal("skinloaded",skin)
	
