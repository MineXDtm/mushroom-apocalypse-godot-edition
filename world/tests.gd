extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cords = [16,48,80,112,144,176,208,240,272,304,336,368,400,432,464,496]
var random_x = 16
var random_y = 16

func _ready():
	randomize()
	for i in range(randi() % 17):
		random_x = cords[i]
	for i2 in range(randi() % 16):
		random_y = cords[i2]
	var random_pos = Vector2(random_x,random_y)
	position = random_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
