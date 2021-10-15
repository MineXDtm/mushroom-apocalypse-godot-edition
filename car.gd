extends Area2D
var inmenu = false
var health = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type = "car"
var layer = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	positionate_arrow(Rect2(top_left,size))
	rotare()
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

func positionate_arrow(bounds : Rect2):
	if bounds.has_point(global_position):
		get_parent().get_parent().get_node("arrow_scene").visible = false
	else:
		get_parent().get_parent().get_node("arrow_scene").visible = true
	get_parent().get_parent().get_node("arrow_scene").global_position.x = clamp(position.x,bounds.position.x, bounds.end.x)
	get_parent().get_parent().get_node("arrow_scene").global_position.y = clamp(position.y,bounds.position.y, bounds.end.y)
func rotare():
	var angle = (global_position - get_parent().get_parent().get_node("arrow_scene").global_position).angle()
	get_parent().get_parent().get_node("arrow_scene").global_rotation = angle
	get_parent().get_parent().get_node("arrow_scene/arrow").global_rotation = 0
func _on_car_area2_area_entered(area):
	if area.is_in_group("body") and area.is_in_group("player"):
		if inmenu == false:
			area.get_parent().opened = true
			get_parent().get_parent().get_parent().get_node("UI2/Control").visible = true
			get_parent().get_parent().get_parent().get_node("UI2/Control/ViewportContainer/Viewport").gui_disable_input = false
			inmenu = true
		else:
			get_parent().get_parent().get_parent().get_node("UI2/Control").visible = false
			get_parent().get_parent().get_parent().get_node("UI2/Control/ViewportContainer/Viewport").gui_disable_input = true
			inmenu = false
			area.get_parent().opened = false


func _on_Area2D_area_entered(area):
	if area.is_in_group("body") and area.is_in_group("player"):
		if inmenu == false:
			area.get_parent().opened = true
			get_parent().get_parent().get_parent().get_node("UI2/Control").visible = true
			get_parent().get_parent().get_parent().get_node("UI2/Control/ViewportContainer/Viewport").gui_disable_input = false
			inmenu = true
		else:
			get_parent().get_parent().get_parent().get_node("UI2/Control").visible = false
			get_parent().get_parent().get_parent().get_node("UI2/Control/ViewportContainer/Viewport").gui_disable_input = true
			inmenu = false
			area.get_parent().opened = false
