extends Sprite

var mPos
var locs = []
var mat
var cPos
var angLock

func listf(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

func px2cm(px):
	return (px * 202.0/1196.0)

func _ready():
	mat = get_node("/root/city_shaper").texture.get_size()
	locs.append([position[0], position[1], 0, $Ray.global_transform.origin.distance_to($Ray.get_collision_point())])
	print(locs)
	print(mat)

func _input(event):
	if event is InputEventMouseButton:
		if event.position[0] < 1196 and event.position[1] < 672 and event.pressed and event.button_index == BUTTON_LEFT:
			print("created waypoint --> x: ", event.position.x, " y: ", mat.y - event.position.y - 1)
			mPos = get_local_mouse_position()
			rotation += mPos.angle()
			position = event.position
			var origin = $Ray.global_transform.origin
			var cPoint = $Ray.get_collision_point()
			var dist = origin.distance_to(cPoint)
			locs.append([event.position.x, event.position.y, rotation, dist])
			get_node("/root/city_shaper/Node2D").update()

	if event is InputEventKey:
		if event.control:
			if event.scancode == KEY_Z and event.pressed:
				if len(locs) > 1:
					var remWay = locs.pop_back()
					print("removed waypoint --> x: ", remWay[0], " y: ", mat.y - remWay[1] - 1)
					position = Vector2(locs[len(locs)-1][0], locs[len(locs)-1][1])
					rotation = locs[len(locs)-1][2]
					get_node("/root/city_shaper/Node2D").update()

			if event.scancode == KEY_P and event.pressed:
				print("\nPath")
				print("-----------------------------------------")
				var i = 0
				for loc in locs:
					if i > 0:
						print("x: ", loc[0], " y: ", mat.y - 1 - loc[1], " ang: ", rad2deg(loc[2]) - rad2deg(locs[i-1][2]), " dist: ", loc[3])
					else:
						print("x: ", loc[0], " y: ", mat.y - 1 - loc[1], " ang: ", rad2deg(loc[2]), " dist: ", loc[3])
					i = i + 1
				print("-----------------------------------------")

			if event.scancode == KEY_S and event.pressed:
				print("saving")
				var fPol = File.new()
				var fDat = File.new()
				var id = "user://path" + str(len(listf("user://"))/2)
				var idPol = id + ".eppf"
				var idDat = id + ".dat"
				var polar = ""
				var dat = str(mat.x) + " " + str(mat.y) + "\n"
				var i = 0
				for loc in locs:
					if i > 0:
						polar = polar + "r" + str(int(rad2deg(loc[2]) - rad2deg(locs[i-1][2]))) + "r m" + str(px2cm(loc[3])) + "m\n"
					else:
						polar = polar + "r" + str(int(rad2deg(loc[2]))) + "r m" + str(px2cm(loc[3])) + "m\n"
					dat = dat + str(loc[0]) + " " + str(loc[1]) + str(loc[2]) + str(loc[3]) + "\n"
					i = i + 1

				# save "polar" coordinates

				fPol.open(idPol, File.WRITE)
				fPol.store_string(polar)
				fPol.close()

				# save coordinate data

				fDat.open(idDat, File.WRITE)
				fDat.store_string(dat)
				fDat.close()
