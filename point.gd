extends TextureButton

var index = "1"
func clicked():
	get_parent().get_parent().point = index
