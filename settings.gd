extends Node

var shadow_mode ="low"
var scalee = 2
signal change_settings
signal changed_scale
func change():
	emit_signal("change_settings")
func change_scale():
	emit_signal("changed_scale")