extends Node



func _got_animation(result, response_code, headers, body:PoolByteArray,player,animname):
	if player != null:
		var f = File.new()
		f.open("res://Emotes/shopload.tres",File.WRITE)
		f.store_buffer(body)
		f.close()
		player.add_animation(animname,load("res://Emotes/shopload.tres"))
		
		player.play(animname)
func loademote(anim,player):
	if player != null:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.connect("request_completed", self, "_got_animation",[player,anim])
		var error = http_request.request("http://minexdtm.com/mushroom-anim/"+anim+".tres")
		if error != OK:
			push_error("An error occurred in the HTTP request.")
