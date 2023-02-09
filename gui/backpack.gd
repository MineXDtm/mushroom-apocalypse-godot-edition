extends TextureButton


func _on_backpack_mouse_entered():
	if disabled == false:
		set_as_toplevel(true)
		get_node("AnimationPlayer").play("backpackhover")
		get_node("AnimationPlayer2").play("backpackhover")
func _ready():
	disabled = true
	$TextureRect.visible = false
	modulate = Color(0.556863, 0.556863, 0.556863)

func _on_backpack_mouse_exited():
	if disabled == false:
		get_node("AnimationPlayer").play_backwards("backpackhover")
		get_node("AnimationPlayer2").play_backwards("backpackhover")
		yield(get_node("AnimationPlayer"),"animation_finished")
		set_as_toplevel(false)
