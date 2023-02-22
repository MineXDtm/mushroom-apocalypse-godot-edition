extends Node
const HealthBar = preload("res://systems/parts/HealthBar.tscn")
export var health =5
export var max_health=5
export var BarPosition = Vector2.ZERO
signal dead
var healthbar_ : ProgressBar = null
func demage(value):
	health -= value
	if health <= 0:
		emit_signal("dead")

func _process(delta):
	if health < max_health and healthbar_ == null:
		healthbar_ = HealthBar.instance() as ProgressBar
		get_parent().add_child(healthbar_)
		healthbar_.rect_position = (BarPosition - Vector2(healthbar_.rect_size.x/2,healthbar_.rect_size.y/2))
		yield(get_tree().create_timer(5),"timeout")
	if healthbar_:
		if health < max_health:
			healthbar_.visible = true
		else:
			healthbar_.visible = false
		healthbar_.max_value = max_health
		healthbar_.value = health

