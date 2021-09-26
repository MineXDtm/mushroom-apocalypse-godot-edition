extends Area2D
func _process(_delta):
	if get_parent().noplayerfinded == true and get_parent().block_pos == null:
		$CollisionShape2D.disabled = false
		$CollisionShape2D.position.x -= 32
	else:
		$CollisionShape2D.disabled = true
		$CollisionShape2D.position.x = -32

func _on_body_area_entered(area):
	if area.is_in_group("limit"):
		$CollisionShape2D.position.x = -32
	if area.is_in_group("stone"):
		$CollisionShape2D.position.x = -32
	if area.is_in_group("kust"):
		$CollisionShape2D.position.x = -32
	if area.is_in_group("kust_fruit"):
		$CollisionShape2D.position.x = -32
