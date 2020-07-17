extends Node2D

func _draw():
	for i in range(len($robot.locs)):
		if i > 0:
			draw_line(Vector2($robot.locs[i-1][0], $robot.locs[i-1][1]), Vector2($robot.locs[i][0], $robot.locs[i][1]), Color(1, 0, 0), 5, true)
