extends Area2D
var health = 10
var broked = false
var cords = [16,48,80,112,144,176,208,240,272,304,336,368,400,432,464,496]
var cords2 = [0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480]
var random_x = 16
var random_y = 16
var number = 0
var number2 = 0
var type = "torch"
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_AnimatedSprite_animation_finished():
	if broked == true :
		broked = false
		for _i in Ganaretor.zombie:
			if Ganaretor.zombies.has(_i) == true:
				var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
				var _world = get_parent()
				var navigation = navigationscene.instance()
				navigation.position.x = cords2[number]
				navigation.position.y = cords2[number2]
				get_parent().get_node(str("zombie",_i)).add_child(navigation)
				navigation.position.x = cords2[number]
				navigation.position.y = cords2[number2]
		var world = get_parent()
		var drop_scene = load("res://world/drop/ItemDrop_wood.tscn")
		var _drop_intance = drop_scene.instance()
		_drop_intance.position = position
		world.add_child(_drop_intance)
		_drop_intance.position = position
		queue_free()


func _on_torch_area_entered(area):
	if area.is_in_group("arm") and broked == false:
		health -= 1
		print(position.y, name)
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
	if area.is_in_group("wooden_exe") and broked == false:
		health -= 1.3
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
	if area.is_in_group("wooden_pickaxe") and broked == false:
		health -= 0.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
	if area.is_in_group("stone_pickaxe") and broked == false:
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
	if area.is_in_group("stone_exe") and broked == false:
		health -= 1.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			$ProgressBar.visible = false
			broked = true
