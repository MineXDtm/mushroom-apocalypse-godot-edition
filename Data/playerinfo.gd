extends Node


func create_ac(token):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "createaccaunt")
	var headers = ["Content-Type: application/json"]
	var body = {"type":"create_accaunt","token":str(epic.token)}
	body = JSON.print(body)
	var error = http_request.request("http://127.0.0.1:3000",headers, true, HTTPClient.METHOD_POST, body [http_request])
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
func createaccaunt(result, response_code, headers, body ,http : HTTPRequest):
	var result_body := JSON.parse(body.get_string_from_utf8()).result as Dictionary
	print(result_body)
	http.queue_free()
	
