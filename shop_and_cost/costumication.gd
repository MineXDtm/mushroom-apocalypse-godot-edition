extends Control
var emotes = {}
var selected = null
var selectedbar = null
func _ready():
	
	for i in get_node("HBoxContainer/custumications/CenterContainer/list/emotes").get_children():
		if i.name == "center":continue
		var b = i as Button
		b.connect("pressed",self,"emote_edit" , [b])
		var a = i.get_node("CenterContainer/TextureRect/Viewport/playerview/player") as AnimationPlayer
		
		a.connect("animation_finished",self,"animended",[a])
		if !emotes.has(str(int(i.name))):
			i.get_node("CenterContainer").visible = false
			continue
		
		
		applyemote(emotes[str(int(i.name))], a)
func emoteloadedd(emote : Animation,animname : String, parameters):
	print(is_instance_valid(parameters[1]))
	parameters[0].add_animation(animname,emote)
	parameters[1].add_animation(animname,emote)
	parameters[0].play(animname)
func animended(track,a):
	a.play(track)
func emote_edit(s):
	selectedbar = s
	$HBoxContainer/custumications.visible = false
	$HBoxContainer/selectionmenu.visible = true
	var allemotes = []
	var bar = load("res://player_model/barselect.tscn")
	for i in allemotes:
		var bar_i = bar.instance() 
		bar_i.name = i
		var a = bar_i.get_node("CenterContainer/TextureRect/Viewport/playerview/player") as AnimationPlayer
		a.connect("animation_finished",self,"animended",[a])
		bar_i.connect("mouse_entered",self,"playanim",[i])
		bar_i.connect("pressed",self,"select" ,[bar_i])
		if !Emotemanager.loadedanimation.has(i):
			Emotemanager.loademote(i,"emoteloadedinlist",[a,bar_i, get_node("/root/menu/Viewport/playerview/player"), get_node("/root/menu/Viewport/playerview")] ,self)
		else:
			emoteloadedinlist(Emotemanager.loadedanimation[i]["emote"],i,[a,bar_i, get_node("/root/menu/Viewport/playerview/player"), get_node("/root/menu/Viewport/playerview")] )
		
		$HBoxContainer/selectionmenu/Panel/MarginContainer/VBoxContainer/ScrollContainer/GridContainer.add_child(bar_i)
func playanim(anim):
	get_node("/root/menu/Viewport/playerview/player").play(anim)

func emoteloadedinlist(emote : Animation,animname : String, parameters):
	parameters[0].add_animation(animname,emote)
	parameters[2].add_animation(animname,emote)
	if Emotemanager.loadedanimation[animname].has("audio"):
		
		var audio = AudioStreamPlayer.new()
		audio.name = animname
		audio.volume_db = -10.0
		audio.stream = Emotemanager.loadedanimation[animname]["audio"]
		parameters[3].get_node("audio").add_child(audio)
	parameters[0].play(animname)
	parameters[1].set("custom_styles/hover", load("res://barthemes/barselect"+Emotemanager.loadedanimation[animname]["type"]+"hover.tres"))
	parameters[1].set("custom_styles/normal", load("res://barthemes/barselect"+Emotemanager.loadedanimation[animname]["type"]+".tres"))
	parameters[1].set("custom_styles/pressed", load("res://barthemes/barselect"+Emotemanager.loadedanimation[animname]["type"]+"pressed.tres"))
	parameters[1].set("custom_styles/disabled", load("res://barthemes/barselect"+Emotemanager.loadedanimation[animname]["type"]+"selected.tres"))
func select(bar):
	if selected != null and is_instance_valid(selected):
		selected.disabled = false
		selected = null
	bar.disabled = true
	selected = bar
	
func applyemote(emotename , anim):
	
	if !Emotemanager.loadedanimation.has(emotename) :
		Emotemanager.loademote(emotename,"emoteloadedd",[anim , get_node("/root/menu/Viewport/playerview/player")] ,self)
	elif Emotemanager.loadedanimation[emotename].has("emote") :
		emoteloadedd(Emotemanager.loadedanimation[emotename]["emote"],emotename,[anim, get_node("/root/menu/Viewport/playerview/player")] )
	else:
		yield(get_tree().create_timer(1),"timeout")
		applyemote(emotename , anim)

func _on_apply_pressed():
	if selected != null:
		emotes[str(int(selectedbar.name))] = selected.name
		var anim = selectedbar.get_node("CenterContainer/TextureRect/Viewport/playerview/player")
		applyemote(selected.name ,anim )
		
		for i in $HBoxContainer/selectionmenu/Panel/MarginContainer/VBoxContainer/ScrollContainer/GridContainer.get_children():
			i.queue_free()
		selectedbar.get_node("CenterContainer").visible = true
		$HBoxContainer/custumications.visible = true
		$HBoxContainer/selectionmenu.visible = false
		


func _on_Button_pressed():
	var cemotes = {}
	for i in emotes.keys():
		cemotes["\""+i+"\""] = "\""+emotes[i]+"\""
	var callemotes = []
	for i in []:
		callemotes.append("\""+i+"\"")
	var callskins = []
	for i in []:
		callskins.append("\""+i+"\"")
	var cskin = "null"
	#epic.call("setplayerinfo",cemotes,callemotes,callskins,cskin)
	
