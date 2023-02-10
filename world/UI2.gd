extends CanvasLayer
func inte():
	$hand_slots.initialize_inventory()
	$inventory.initialize_inventory()
func _ready():
	yield(get_tree().create_timer(1),"timeout")
	yield(get_tree().create_timer(3),"timeout")
#	for i in get_node("emotes/GridContainer").get_children():
#			if i.name == "center":continue
#			if $emotes.emoteslist.size() < int(i.name):continue
#			i.get_node("CenterContainer/TextureRect/Viewport/playerview/player").play($emotes.emoteslist[int(i.name)])


func openinv():
	$inventory.visible = !$inventory.visible
func _physics_process(_delta):
	if Input.is_action_just_pressed("menu") and get_parent().get_node(str(WorldData.map,"/sort/player")).opened == false and get_node("inventory").visible == false:
		if $game_menu.visible == false:
			$game_menu.visible = true
			get_tree().paused = true
			get_parent().get_node(str(WorldData.map,"/sort/player")).in_menu = true
		else:
			$game_menu.visible = false
			get_tree().paused = false
			get_parent().get_node(str(WorldData.map,"/sort/player")).in_menu = false
	


func _input(event):
	if event.is_action_pressed("emotebar"):
		$emotes.visible = true
		
	if event.is_action_released("emotebar"):
		$emotes.visible = false
		
		if $emotes.selected != null and $emotes.emoteslist.has(str(int($emotes.selected))):
			var p = get_parent().get_node(str(WorldData.map,"/sort/player/player")) as AnimationPlayer
			get_parent().get_node(str(WorldData.map,"/sort/player")).emote = true
			
			p.play($emotes.emoteslist[str(int($emotes.selected))])
