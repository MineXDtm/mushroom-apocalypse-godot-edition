extends Polygon2D
var random = RandomNumberGenerator.new()
func _physics_process(delta):
	position = position.move_toward(Vector2(0,2) + position, delta * 25)
func _ready():
	random.randomize()
	position.x += random.randi_range(-15,15)
	position.y += random.randi_range(-15,15)
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()
