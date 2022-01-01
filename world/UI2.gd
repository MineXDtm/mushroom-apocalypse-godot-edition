extends CanvasLayer
func inte():
	$hand_slots.initialize_inventory()
	$inventory.initialize_inventory()
func ready():
	for i in get_node("emotes/GridContainer").get_children():
			if i.name == "center":continue
			if $emotes.emoteslist.size() < int(i.name):continue
			i.get_node("CenterContainer/TextureRect/Viewport/playerview/player").play($emotes.emoteslist[int(i.name)])
			
func openinv():
	$inventory.visible = !$inventory.visible
	$inventory.initialize_inventory()

func _physics_process(_delta):
	if Input.is_action_just_pressed("menu") and get_parent().get_node(str(WorldData.map,"/sort/player")).opened == false and get_node("inventory").visible == false:
		if $game_menu.visible == false:
			$game_menu.visible = true
			get_parent().get_node(str(WorldData.map,"/sort/player")).in_menu = true
		else:
			$game_menu.visible = false
			get_parent().get_node(str(WorldData.map,"/sort/player")).in_menu = false
	
	$hand_slots.initialize_inventory()
	$inventory.initialize_inventory()

func _input(event):
	if event.is_action_pressed("emotebar"):
		$emotes.visible = true
		
	if event.is_action_released("emotebar"):
		$emotes.visible = false
		if $emotes.selected != null:
			pass
