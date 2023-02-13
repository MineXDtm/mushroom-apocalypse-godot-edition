extends Node
const HealthBar = preload("res://systems/parts/HealthBar.tscn")
export var health =5
export var max_health=5
export var BarPosition = Vector2.ZERO
signal dead
var healthbar_ : ProgressBar
func damage(value):
	health -= value
	print(value)
	health -= 1
	if health <= 0:
		emit_signal("dead")
	
func _process(delta):
	if health < max_health and not healthbar_:
		var HealthBar_s = HealthBar.instance()
		HealthBar_s.position = BarPosition
		healthbar_=HealthBar_s
		get_parent().add_child(HealthBar_s)
	if healthbar_:
		if health < max_health:
			healthbar_.visible = true
		else:
			healthbar_.visible = false
		
		healthbar_.max_value = max_health
		healthbar_.value = health
	
