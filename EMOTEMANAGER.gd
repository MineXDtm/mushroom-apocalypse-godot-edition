extends Node
var loadedanimation = {
	
}

func _ready():
	dir_contents("res://Emotes/")
func _got_animation(result, response_code, headers, body : PoolByteArray,animname,function,parameters,object ):
	
	var f = File.new()
	f.open("res://Emotes/"+animname+".tres",File.WRITE)
	
	f.store_buffer(body)
	f.close()
	var emote = load("res://Emotes/"+animname+".tres")
	print(emote.resource_name + " is loaded")
	
	loadedanimation[animname]["emote"] = emote
	object.call(function,emote,animname,parameters)
func loademote(anim,function, parameters,object):
	loadedanimation[anim] = {}
	var http_request = HTTPRequest.new()
	add_child(http_request)
	print(anim + " is loading")
	http_request.connect("request_completed", self, "_got_info",[anim,function,parameters,object])
	var error = http_request.request("http://minexdtm.com/mushroom-anim/emoteinfo/"+anim+".json")
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func _got_info(result, response_code, headers, body : PoolByteArray,animname,function,parameters,object ):
	
	
	var info = parse_json(body.get_string_from_utf8())
	print(body.get_string_from_utf8())
	loadedanimation[animname]["type"] = info["type"]
	if info["audio"] == true:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		print(animname+ " is loading")
		http_request.connect("request_completed", self, "_got_audio",[animname,function,parameters,object])
		var error = http_request.request("http://minexdtm.com/mushroom-anim/emoteaudio/"+animname+".mp3")
		yield(http_request, "request_completed")
		if error != OK:
			push_error("An error occurred in the HTTP request.")
		 
	
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	print(animname+ " is loading")
	http_request.connect("request_completed", self, "_got_animation",[animname,function,parameters,object])
	var error = http_request.request("http://minexdtm.com/mushroom-anim/emoteanim/"+animname+".tres")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	#_got_audio
func _got_audio(result, response_code, headers, body : PoolByteArray,animname,function,parameters,object ):
	
	var stream = AudioStreamMP3.new()
	stream.data = body
	loadedanimation[animname]["audio"] =stream
	
	

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if not file_name.begins_with("."):
					dir_contents(str(path,"/",file_name))
			else:
				dir.remove(path+"/"+file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
