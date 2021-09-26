extends Node2D
var time = "day"
var cooldown = false
var zombies = {
	
}
var zombie = 0
func _ready():
	var enemyscene = load("res://bucket.tscn")
	for _i in range(0,100):
		Ganaretor.kustes += 1
		var enemy = enemyscene.instance()
		get_node("sort").add_child(enemy)
func _on_kust_spawn_timeout():
	if Ganaretor.kustes < 100 :
		var enemyscene = load("res://bucket.tscn")
		for _i in range(0,1):
			Ganaretor.kustes += 1
			var enemy = enemyscene.instance()
			get_node("sort").add_child(enemy)








func _on_time_timeout():
	if time == "day" :
		time = "night"
		$CanvasModulate.color = Color(0.294118, 0.294118, 0.294118)
	else:
		time = "day"
		$CanvasModulate.color = Color(1, 1, 1)


func _on_zombie_spawn_timeout():
	if WorldData.map == name:
		cooldown = false
		if time == "night" :
			var zombiee = load("res://world/zombie1.tscn")
			for _i in range(0,1):
				zombie += 1
				var zombiess = zombiee.instance()
				for i in zombie:
					if zombies.has(i) == false and cooldown == false:
						zombies[i] = [i,str("zombie",i),str("mob",i)]
						zombiess.name = str("mob",zombies[i][0])
						cooldown = true
				get_node("zombie").add_child(zombiess)


func _on_time_move_timeout():
	get_parent().get_node("UI2/time/bg/ScrollContainer").scroll_horizontal += 1
