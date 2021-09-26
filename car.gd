extends Area2D
var inmenu = false
var health = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type = "car"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	get_parent().get_parent().get_parent().get_node("UI2/bars/car/bg/bar_health").value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(_delta):
	if health <= 0:
		get_parent().get_parent().get_parent().get_node("UI2/car_broked").visible = true
		get_parent().get_node("player").died = true
		get_tree().paused = true

func _on_area_car_area_entered(area):
	if area.is_in_group("zombie_arm"):
		health -= 1


func remove(point):
	inmenu = false
	var new_parent = get_parent().get_parent().get_parent().get_node(str("map",point,"/sort"))
	if point == "1":
		new_parent = get_parent().get_parent().get_parent().get_node("map/sort")
	get_parent().remove_child(self)
	new_parent.add_child(self)
	position = Vector2(752,624)


func _on_car_area2_area_entered(area):
	if area.is_in_group("body") and area.is_in_group("player"):
		if inmenu == false:
			area.get_parent().opened = true
			get_parent().get_parent().get_parent().get_node("UI2/map").visible = true
			inmenu = true
		else:
			get_parent().get_parent().get_parent().get_node("UI2/map").visible = false
			inmenu = false
			area.get_parent().opened = false
