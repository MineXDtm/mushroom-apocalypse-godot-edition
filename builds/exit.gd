extends Area2D
var type = "exit"


func _on_exit_area_entered(area):
	check(area)
func _on_exit2_area_entered(area):
	check(area)

func _on_exit3_area_entered(area):
	check(area)
func _on_exit4_area_entered(area):
	check(area)
func _on_exit5_area_entered(area):
	check(area)
func _on_exit6_area_entered(area):
	check(area)
func _on_exit7_area_entered(area):
	check(area)
func _on_exit8_area_entered(area):
	check(area)


func check(area):
	if area.name != "Node2D" and area.name != "exit" and area.name != "exit2" and area.name != "exit3" and area.name != "exit4"  and area.name != "armsattack"  and area.name != "buildblock" and area.name != "wooden_pickaxe" and area.name != "body" and area.name != "stone_pickaxe"  and area.name != "stone_exe" and area.name != "navarea" and area.name != "zombie_armsattack" and area.name != "area" and area.name != "block_area" and area.name != "kust_fruit_build" and area.name != "area_car":
		if area.is_in_group("buildblock"):
			pass
		elif area.is_in_group("wooden_floor"):
			pass
		elif area.is_in_group("zombie_area"):
			pass
		elif area.is_in_group("zombie_dis"):
			pass
		elif area.is_in_group("door_area"):
			pass
		elif area.is_in_group("car_area"):
			pass
		elif area.is_in_group("limit"):
			pass
		elif area.is_in_group("drop"):
			pass
		elif area.is_in_group("damage"):
			pass
		elif area.is_in_group("player_area"):
			pass
		else:
			queue_free()
			
