extends Node

var shadow_mode ="low"
signal change_settings
func change():
	emit_signal("change_settings")
