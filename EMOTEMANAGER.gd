extends Node
var loadedanimation = []

signal emoteloaded(emote,animname)
func _got_animation(result, response_code, headers, body : PoolByteArray,animname):
	var f = File.new()
	f.open("res://Emotes/remote_anim.tres",File.WRITE)
	f.store_buffer(body)
	f.close()
	var emote =load("res://Emotes/remote_anim.tres")
	loadedanimation.append(emote)
	emit_signal("emoteloaded",emote,animname)
func loademote(anim):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_got_animation",[anim])
	var error = http_request.request("http://minexdtm.com/mushroom-anim/"+anim+".tres")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
