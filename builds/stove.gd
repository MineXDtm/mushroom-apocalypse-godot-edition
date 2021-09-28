extends Area2D
var health = 12
var opened = false
var cords = [16,48,80,112,144,176,208,240,272,304,336,368,400,432,464,496]
var cords2 = [0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,480]
var number = 0
var number2 = 0
var fire = []
var added = []
var fire_value = 0
var progres = 0
var type = "stove"
var layer = 1
var time = {
	"piece_of_rust":[60,"iron"]
}
var fire_time = {
	"coal":[140]
}
var completed = []
var items = ["piece_of_rust"]
var in_gui = false
var paused = false
func _ready():
	for i in range(0,16):
		if cords[i] == position.x:
			number = cords2[i]
		if cords[i] == position.y:
			number2 = cords2[i]
func _physics_process(_delta):
	if added.size() == 0 and fire_value != 0 and paused == false:
		$fire.paused = true
		paused = true
	elif paused == true and added.size() != 0:
		$fire.paused = false
		$fire.start()
		paused = false
	if fire_value == 0 and fire.size() != 0:
		var ui = get_parent().get_parent().get_node("ui/stove_ui")
		fire_value += 100
		ui.get_node("fire_bar").value = fire_value
		fire[1] -= 1
		if fire[1] == 0:
			fire.clear()
			ui.get_node("added2").visible = false
		else:
			ui.get_node("added2/Label").text = str(fire[1])
		$fire.start()
	if Input.is_action_just_pressed("add") and in_gui == true:
		if added.size() == 0 and completed.size() == 0: 
			if PlayerInventory.inventory1.has(int(get_parent().get_node("player").invenory_slot) - 1):
				for i in items:
					if PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0] == i:
						var ui = get_parent().get_parent().get_node("ui/stove_ui")
						added.append(PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0])
						ui.get_node("added").visible = true
						ui.get_node("added").texture = load("res://textures/items/" + PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0] + ".png")
						var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
						inventory1.place(str("slot",get_parent().get_node("player").invenory_slot))
						for ii in time:
							if ii == i:
								$prog.wait_time = 100 / time[ii][0]
						$prog.start()
		for i in fire_time:
			if PlayerInventory.inventory1.has(int(get_parent().get_node("player").invenory_slot) - 1):
				if PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0] == i and fire.size() == 0:
					var ui = get_parent().get_parent().get_node("ui/stove_ui")
					var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
					fire.append(PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0])
					fire.append(1)
					ui.get_node("added2/Label").text = str(fire[1])
					ui.get_node("added2").visible = true
					ui.get_node("added2").texture = load("res://textures/items/" + PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0] + ".png")
					inventory1.place(str("slot",get_parent().get_node("player").invenory_slot))
				elif fire.size() != 0 and fire[1] != 99 and PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0] == i:
					if PlayerInventory.inventory1[int(get_parent().get_node("player").invenory_slot) - 1][0] == fire[0]:
						var inventory1 = get_parent().get_parent().get_parent().get_node("UI2/inventory")
						inventory1.place(str("slot",get_parent().get_node("player").invenory_slot))
						var ui = get_parent().get_parent().get_node("ui/stove_ui")
						fire[1] += 1
						ui.get_node("added2/Label").text = str(fire[1])
		if completed.size() != 0:
			var ui = get_parent().get_parent().get_node("ui/stove_ui")
			PlayerInventory.add_item(completed[0], 1)
			completed.clear()
			ui.get_node("done").visible = false
func _on_stove_area_entered(area):
	if area.is_in_group("player_area"):
		var ui = get_parent().get_parent().get_node("ui/stove_ui")
		if fire.size() != 0:
			ui.get_node("added2/Label").text = str(fire[1])
		ui.visible = true
		ui.rect_position = position
		ui.rect_position.x -= 30
		ui.rect_position.y -= 40
		in_gui = true
		ui.get_node("fire_bar").value = fire_value
		ui.get_node("ProgressBar").value = progres
		if fire.size() == 0:
			ui.get_node("added2").visible = false
		else:
			ui.get_node("added2").visible = true
			ui.get_node("added2").texture = load("res://textures/items/" + fire[0] + ".png")
		if added.size() == 0:
			ui.get_node("added").visible = false
		else:
			ui.get_node("added").visible = true
			ui.get_node("added").texture = load("res://textures/items/" + added[0] + ".png")
	if area.is_in_group("arm"):
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 : 
			broked = true
	if area.is_in_group("wooden_exe"):
		health -= 1.3
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 : 
			broked = true
	if area.is_in_group("wooden_pickaxe"):
		health -= 0.5
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 : 
			broked = true
	if area.is_in_group("stone_pickaxe"):
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 : 
			broked = true
	if area.is_in_group("stone_exe"):
		health -= 1.7
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 : 
			broked = true
	if area.is_in_group("zombie_arm"):
		health -= 1
		$ProgressBar.visible = true
		$ProgressBar.value = health
		if health <= 0 :
			broked = true
	if broked == true and brokede == false:
		brokede = true
		var navigationscene = load("res://world/NavigationPolygonInstance.tscn")
		var navigation = navigationscene.instance()
		navigation.position.x = cords2[number]
		navigation.position.y = cords2[number2]
		navigation.added_by_gen = false
		get_parent().get_parent().get_node("zombies").call_deferred("add_child", navigation)
		var world = get_parent()
		var exit_scene = load("res://exit.tscn")
		var _exit_intance = exit_scene.instance()
		_exit_intance.position = position
		world.call_deferred("add_child", _exit_intance)
		_exit_intance.position = position
		var drop_scene = load("res://world/drop/ItemDrop.tscn")
		var _drop_intance = drop_scene.instance()
		_drop_intance.item_name = "stove"
		_drop_intance.position = position
		world.call_deferred("add_child", _drop_intance)
		_drop_intance.position = position
		queue_free()

func _on_stove_area_exited(area):
	if area.is_in_group("player_area"):
		var ui = get_parent().get_parent().get_node("ui/stove_ui")
		ui.visible = false
		in_gui = false
var brokede = false
var broked = false
func _on_prog_timeout():
	if fire_value != 0:
		var ui = get_parent().get_parent().get_node("ui/stove_ui")
		progres += 1
		if in_gui == true:
			ui.get_node("ProgressBar").value = progres
		if progres == 100:
			$prog.stop()
			ui.get_node("added").visible = false
			for ii in time:
				if ii == added[0]:
					ui.get_node("added").texture = load("res://textures/items/" + time[ii][1] + ".png")
					completed.append(time[ii][1])
					$stove.frame = 0
					$Light2D.visible = false
			added.remove(0)
			progres = 0
			ui.get_node("ProgressBar").value = progres
			ui.get_node("done").visible = true


func _on_fire_timeout():
	var ui = get_parent().get_parent().get_node("ui/stove_ui")
	fire_value -= 1
	$stove.frame = 1
	$Light2D.visible = true
	if in_gui == true:
		ui.get_node("fire_bar").value = fire_value
	if fire_value == 0:
		$fire.stop()
		$stove.frame = 0
		$Light2D.visible = false
