extends TextureButton
var me = "0"
var point = "1"
var passed = false
var finded = 0
onready var map = get_parent().get_parent().get_parent().get_parent().get_parent()
var cooldown = true
func _process(_delta):
	if map.getted[int(point)][me] == map.res_namber[int(point)][me]:
		disabled = true
func _on_but_pressed():
	finded = 0
	for item in PlayerInventory.inventory1:
		if PlayerInventory.inventory1[item][0] == map.res[int(point)][me]:
			finded += 1
	for item in PlayerInventory.inventory:
		if PlayerInventory.inventory[item][0] == map.res[int(point)][me]:
			finded += 1
	for i in finded:
		cooldown = false
		for item in PlayerInventory.inventory1:
			if PlayerInventory.inventory1[item][0] == map.res[int(point)][me] and cooldown == false:
				while map.getted[int(point)][me] != map.res_namber[int(point)][me] and cooldown == false:
					get_parent().get_node("ProgressBar").value += 1
					map.getted[int(point)][me] += 1
					get_parent().get_node("ProgressBar/Label").text = str(map.getted[int(point)][me],"/",map.res_namber[int(point)][me])
					PlayerInventory.inventory1[item][1] -= 1
					if PlayerInventory.inventory1[item][1] == 0 and cooldown == false:
						PlayerInventory.inventory1.erase(item)
						var inventory1 = map.get_parent().get_node("inventory")
						inventory1.finder(item)
						cooldown = true
		for item in PlayerInventory.inventory:
			if PlayerInventory.inventory[item][0] == map.res[int(point)][me] and cooldown == false:
				while get_parent().get_parent().get_parent().getted[int(point)][me] != map.res_namber[int(point)][me] and cooldown == false:
					get_parent().get_node("ProgressBar").value += 1
					map.getted[int(point)][me] += 1
					get_parent().get_node("ProgressBar/Label").text = str(map.getted[int(point)][me],"/",get_parent().get_parent().get_parent().res_namber[int(point)][me])
					PlayerInventory.inventory[item][1] -= 1
					if PlayerInventory.inventory[item][1] == 0 and cooldown == false:
						PlayerInventory.inventory.erase(item)
						var inventory1 = map.get_parent().get_node("inventory")
						inventory1.finder1(item)
						cooldown = true
