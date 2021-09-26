extends Button



func _on_Button_pressed():
	get_parent().get_parent().get_node("UI2/time/bg/ScrollContainer").scroll_horizontal = 23
