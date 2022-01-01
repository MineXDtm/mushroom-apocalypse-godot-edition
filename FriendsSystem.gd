extends Node
var friendbox = preload("res://menu/friend.tscn")
var offline = preload("res://textures/gui/offline.png")
var online = preload("res://textures/gui/online.png")
var away = preload("res://textures/gui/away.png")
var awayforwhile = preload("res://textures/gui/awayforwhile.png")
var busy = preload("res://textures/gui/busy.png")
var list = "/root/menu/menu_1/VBoxContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer"
func addfriend(nickname):
	var fri = friendbox.instance()
	fri.get_node("MarginContainer/HBoxContainer/Nickname").text = nickname
	if(get_node_or_null(list) == null):
		print("fail get list")
		return
	get_node(list).add_child(fri)
func setstatus(index,status):
	if(get_node_or_null(list) == null):
		print("fail get list")
		return
	var fri = get_node(list).get_child(index)
	
	if status == "offline":
		fri.get_node("MarginContainer/HBoxContainer/CenterContainer/sicon").texture = offline
	elif status == "online":
		fri.get_node("MarginContainer/HBoxContainer/CenterContainer/sicon").texture = online
	elif status == "away":
		fri.get_node("MarginContainer/HBoxContainer/CenterContainer/sicon").texture = away
	elif status == "extendedaway":
		fri.get_node("MarginContainer/HBoxContainer/CenterContainer/sicon").texture = awayforwhile
	elif status == "donotdisturb":
		fri.get_node("MarginContainer/HBoxContainer/CenterContainer/sicon").texture = busy
