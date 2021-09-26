extends StaticBody2D
func _ready():
	var enemyscene = load("res://world/kust.tscn")
	for _i in range(0,15):
		Ganaretor.kustes += 1
		var enemy = enemyscene.instance()
		add_child(enemy)

	var fruit = load("res://world/kust_fruit.tscn")
	for _i in range(0,5):
		Ganaretor.fruit_kustes += 1
		var fruits = fruit.instance()
		add_child(fruits)



func _on_kust_spawn_timeout():
	if Ganaretor.kustes < 15 :
		var enemyscene = load("res://world/kust.tscn")
		for _i in range(0,1):
			Ganaretor.kustes += 1
			print(Ganaretor.kustes)
			var enemy = enemyscene.instance()
			add_child(enemy)




func _on_kust_fruit_spawn_timeout():
	if Ganaretor.fruit_kustes < 5 :
		var fruit = load("res://world/kust_fruit.tscn")
		for _i in range(0,1):
			var fruits = fruit.instance()
			add_child(fruits)
