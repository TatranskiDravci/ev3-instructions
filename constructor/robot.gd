extends Sprite

var mPos
var locs = []
var mat
var cPos
var angLock

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
				var fCart = File.new()
				var id = "/home/lukas/.ev3-paths/" + str((randi()%200+1)) + str((randi()%200+1)) + str((randi()%200+1)) + str((randi()%200+1))
				var idPol = id + "polar.rppf"
				var idCart = id + "cartesian.rcpf"
				var polar = ""
				var cart = str(mat.x) + " " + str(mat.y) + "\n"
				var i = 0
				for loc in locs:
					if i > 0:
						polar = polar + "r" + str(int(rad2deg(loc[2]) - rad2deg(locs[i-1][2]))) + "r m" + str(px2cm(loc[3])) + "m\n"
					else:
						polar = polar + "r" + str(int(rad2deg(loc[2]))) + "r m" + str(px2cm(loc[3])) + "m\n"
					cart = cart + str(loc[0]) + " " + str(loc[1]) + "\n"
					i = i + 1

				# save "polar" coordinates

				fPol.open(idPol, File.WRITE)
				fPol.store_string(polar)
				fPol.close()

				# save cartesian coordinates

				fCart.open(idCart, File.WRITE)
				fCart.store_string(cart)
				fCart.close()
