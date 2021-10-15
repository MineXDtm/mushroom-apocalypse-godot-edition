extends Node2D

func positionate_arrow():
	var camera_posn = get_parent().get_node("player/Camera2D").get_camera_position()
	var screensize = OS.get_window_size()
	get_parent().get_parent().get_node("arrow").position.x = clamp(position.x, camera_posn.x - screensize.x / 2 , camera_posn.x + screensize.x / 2 - MARGIN )
	get_parent().get_parent().get_node("arrow").position.y = clamp(position.y, camera_posn.y - screensize.y / 2 , camera_posn.y + screensize.y / 2 - MARGIN )
const MARGIN = 10
