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
		if !Emotemanager.loadedanimation.has(emoteslist[int(i.name) ]):
			Emotemanager.connect("emoteloaded",self,"emoteloadedd",[a,get_parent().get_parent().get_node(str(WorldData.map,"/sort/player/player"))],CONNECT_ONESHOT)
			Emotemanager.loademote(emoteslist[int(i.name) ])
			
func emoteloadedd(emote : Animation,animname : String, anim : AnimationPlayer ,p : AnimationPlayer):
	p.add_animation(animname,emote)
	anim.add_animation(animname,emote)
	anim.play(animname)
func animended(track,a):
	a.play(track)
func hover_emote(id : Button):
	selected = int(id.name)
