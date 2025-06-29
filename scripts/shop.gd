extends CanvasLayer

var currItem = 0
var select = 0

func _ready() -> void:
	
	pass

func _on_close_pressed() -> void:
	get_node("Anim").play("Outlod")
	
func switchItem(select):
	for i in range(Global.items.size()):
		if select == i:
			currItem = select
			get_node("Control/AnimatedSprite2D").play(Global.items[currItem]["name"])
			get_node("Control/name").text = Global.items[currItem]["name"]
			get_node("Control/des").text = Global.items[currItem]["des"]
			get_node("Control/des").text += "\ncost :" + str(Global.items[currItem]["cost"])
	pass


func _on_next_pressed() -> void:
	switchItem(currItem + 1)


func _on_back_pressed() -> void:
	switchItem(currItem - 1)

func _on_buy_pressed() -> void:
	var hasItem = false
	if Global.coin > Global.items[currItem]["cost"]:
		for i in Global.inventory:
			if Global.inventory[i]["name"] == Global.items[currItem]["name"]:
				Global.inventory[i]["count"] += 1
				hasItem = true
		if hasItem == false:
			var tempDic =  Global.items[currItem]
			tempDic["count"] = 1
			Global.inventory[Global.inventory.size()] = tempDic
			Global.coin -= Global.items[currItem]["cost"]
			print(Global.inventory)
