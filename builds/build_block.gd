extends Area2D
var health = 5
var opened = false
var cords = [16]
var cords2 = [0]
var number = 0
var number2 = 0
var entered = false
var mind = null
var map_size = 1536
var needed = 0
var cooldown32 = 16
var added = 16
var added2 = 0
var type = "wooden_trap" 
func _ready():
	while cooldown32 <= map_size:
		cooldown32 += 32
		needed += 1 
	for i in needed:
		added += 32
		added2 += 32
		cords.append(added)
		cords2.append(added2)
	for i in range(0,cords.size()):
		if cords[i] == position.x:
			number =  i
		if cords[i] == position.y:
			number2 = i
	
func _on_buildblock_area_entered(area):
	if area.is_in_group("zombie_dis"):
		if mind == null:
			entered = true
			mind = area

func _on_cooldown_timeout():
	if entered == true:
		$trap.frame = 1
		$wooden_trap_damage/CollisionShape2D.disabled = false
		$cooldown2.start()
	else:
		$cooldown.start()


func _on_Timer_timeout():
	$trap.frame = 0
	$wooden_trap_damage/CollisionShape2D.disabled = true
	$cooldown.start()


func _on_wooden_trap_area_exited(area):
	if area.is_in_group("zombie_dis"):
		if mind != null:
			entered = false
			mind = null
