extends Area2D





func _on_path_area_entered(area):
	if area.is_in_group("player_area"):
		WorldData.playerInpath = name
		
		
func _ready():
	$Label.text = str(name)
