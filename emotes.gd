extends Control

var emoteslist = {}
var selected = null
func _ready():
	for i  in get_node("GridContainer").get_children():
		if i.name == "center":continue
		var b = i as Button

		b.connect("mouse_entered",self,"hover_emote",[i])
		if !emoteslist.has(str(int(i.name))):
			i.get_node("CenterContainer").visible = false
			continue

		var a = i.get_node("CenterContainer/TextureRect/Viewport/playerview/player") as AnimationPlayer

		a.connect("animation_finished",self,"animended",[a])
		apply(i,a)

func apply(i,a):

	if !Emotemanager.loadedanimation.has(emoteslist[str(int(i.name) )]):
			Emotemanager.loademote(emoteslist[str(int(i.name) )],"emoteloadedd",[a,get_parent().get_parent().get_node(str(WorldData.map,"/sort/player/player"))] ,self)
	elif Emotemanager.loadedanimation[emoteslist[str(int(i.name) )]].has('emote') :
			emoteloadedd(Emotemanager.loadedanimation[emoteslist[str(int(i.name) )]]["emote"],emoteslist[str(int(i.name) )],[a,get_parent().get_parent().get_node(str(WorldData.map,"/sort/player/player"))] )
	else:
		yield(get_tree().create_timer(1),"timeout")
		apply(i,a)
func emoteloadedd(emote : Animation,animname : String, parameters):
	if Emotemanager.loadedanimation[animname].has("audio"):
		var audio = Emotemanager.loadedanimation[animname]["audio"]
		var node = AudioStreamPlayer2D.new()
		node.stream = audio
		node.name = animname
		get_parent().get_parent().get_node(str(WorldData.map,"/sort/player/audio")).add_child(node)
	parameters[1].add_animation(animname,emote)
	parameters[0].add_animation(animname,emote)
	parameters[0].play(animname)

func animended(track,a):
	a.play(track)
func hover_emote(id : Button):
	selected = int(id.name)
