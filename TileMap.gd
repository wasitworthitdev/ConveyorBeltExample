extends TileMap

enum CellType {CONVEYORBELT}

var currentRotIterDir: Vector2 = Vector2.UP
var _rotIter = 0

var beltSpeed = 100

func placeConveyorBelt():
	PlaceCellWithDir(getMouseTileMapPos(), currentRotIterDir)

func clearCell():
	set_cellv(getMouseTileMapPos(), INVALID_CELL)

func getMouseTileMapPos() -> Vector2:
	return world_to_map(get_local_mouse_position())

func isCellConveyorBelt(pos: Vector2) -> bool:
	return get_cellv(pos) == CellType.CONVEYORBELT

func cellRotToDir(pos: Vector2) -> Vector2:
	var cellx = pos.x
	var celly = pos.y
	
	var xrot: bool = is_cell_x_flipped(cellx, celly)
	var yrot: bool = is_cell_y_flipped(cellx, celly)
	var trot: bool = is_cell_transposed(cellx, celly)
	
	if xrot == true && yrot == false && trot == true:
		return Vector2.RIGHT
	elif xrot == true && yrot == true && trot == false:
		return Vector2.DOWN
	elif xrot == false && yrot == true && trot == true:
		return Vector2.LEFT
	else:
		return Vector2.UP

func PlaceCellWithDir(pos: Vector2, dir: Vector2):
	match dir:
		Vector2.UP:
			set_cellv(pos, CellType.CONVEYORBELT, true, false, true)
		Vector2.RIGHT:
			set_cellv(pos, CellType.CONVEYORBELT, true, true, false)
		Vector2.DOWN:
			set_cellv(pos, CellType.CONVEYORBELT, false, true, true)
		Vector2.LEFT, _:
			set_cellv(pos, CellType.CONVEYORBELT, false, false, false)

func iterateCellRotDir():
	_rotIter += 1
	if _rotIter > 3:
		_rotIter = 0
	
	match _rotIter:
		0:
			currentRotIterDir = Vector2.UP
		1:
			currentRotIterDir = Vector2.RIGHT
		2:
			currentRotIterDir = Vector2.DOWN
		3, _:
			currentRotIterDir = Vector2.LEFT
