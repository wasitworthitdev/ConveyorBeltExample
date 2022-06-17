extends Node2D

export var tileMapPath: NodePath
var tileMap: Node

var moveTarget = Vector2.ZERO

func _ready():
	tileMap = get_node(tileMapPath)
	position = moveTarget

func _physics_process(delta):
	if position.floor() == moveTarget.floor():
		var occupiedTileMapPos = tileMap.world_to_map(position)
		var nextTileMapPos = calcNextTileMapPos(occupiedTileMapPos)
		
		if tileMap.isCellConveyorBelt(occupiedTileMapPos) && tileMap.isCellConveyorBelt(nextTileMapPos):
			moveTarget = tileMap.map_to_world(nextTileMapPos)
		
	position = position.move_toward(moveTarget, delta * tileMap.beltSpeed)
	
func calcNextTileMapPos(pos: Vector2) -> Vector2:
	var dir: Vector2 = tileMap.cellRotToDir(pos)
	return pos + dir
