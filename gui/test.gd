extends TextureRect


func change():
	if rect_scale.x < gamesettings.scalee:
		rect_scale.x = gamesettings.scalee 
		rect_scale.y = gamesettings.scalee
		rect_position.x = rect_position.x - 65
		rect_position.y = rect_position.y - 30
	else:
		rect_scale.x = gamesettings.scalee 
		rect_scale.y = gamesettings.scalee
		rect_position.x = rect_position.x + 65
		rect_position.y = rect_position.y + 30
func _ready():
	gamesettings.connect("changed_scale",self,"change")

