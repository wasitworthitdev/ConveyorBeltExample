extends Node
export var tileMapPath: NodePath
var tileMap: Node

func _ready():
	tileMap = get_node(tileMapPath)

func _input(event):
	if event.is_action_released("r"):
		tileMap.iterateCellRotDir()
	
	if event.is_action_released("leftClick"):
		tileMap.placeConveyorBelt()
		
	if event.is_action_released("rightClick"):
		tileMap.clearCell()
