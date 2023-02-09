extends Button




func _on_Button_pressed():
	var headers = ["Content-Type: application/json"]
	var body = {"type":"change_emotes","token":str(epic.token),"slot":"0","emotename":"think"}
	body = JSON.print(body)
	var error = get_node("/root/menu/HTTPRequest").request("http://127.0.0.1:3000",headers, true, HTTPClient.METHOD_POST, body)
