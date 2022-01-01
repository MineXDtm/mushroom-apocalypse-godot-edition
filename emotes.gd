extends Control

var emoteslist = ["think"]
var selected = null
func _ready():
	
	
	for i  in get_node("GridContainer").get_children():
		if i.name == "center":continue
		var b = i as Button
		
		b.connect("mouse_entered",self,"hover_emote",[i])
		if emoteslist.size() < int(i.name) +1:
			i.get_node("CenterContainer").visible = false
			continue
		
		var a = i.get_node("CenterContainer/TextureRect/Viewport/playerview/player") as AnimationPlayer
		
		a.connect("animation_finished",self,"animended",[a])
		Emotemanager.loademote(emoteslist[int(i.name) ], i.get_node("CenterContainer/TextureRect/Viewport/playerview/player"))
		
func animended(track,a):
	a.play(track)
func hover_emote(id : Button):
	selected = int(id.name)
