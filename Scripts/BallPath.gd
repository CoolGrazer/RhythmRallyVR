extends Path3D


var height : int = 0


var data = []

func _ready():
	saveCurve()

func _physics_process(delta):
	
	loadCurve(height)
	


func loadCurve(height):
	
	if height == 6:
		data = [Vector3(0.000056, -1.45286, 5.87943), Vector3(0.000056, -0.000799, 5.00428), Vector3(0, 0.399246, -0.028931), Vector3(-0.000122, 0.185423, 0.632131)]
		if curve.point_count == 3:
			curve.remove_point(2)
		curve.set_point_position(0,data[0])
		curve.set_point_position(1,data[1])
		curve.set_point_out(0,data[2])
		curve.set_point_in(1,data[3])
		return
	
	if height == 4:
		data = [Vector3(0.000056, -0.572414, 4.74451), Vector3(0.000056, 0.076902, 4.17151), Vector3(0, 1.75121, -0.120804), Vector3(0, 4.60177, 0.276292)]
		if curve.point_count == 3:
			curve.remove_point(2)
		curve.set_point_position(0,data[0])
		curve.set_point_position(1,data[1])
		curve.set_point_out(0,data[2])
		curve.set_point_in(1,data[3])
		return
	
	if height == 5:
		data = [Vector3(0, 0, 5), Vector3(2.1392, -0.291539, 3.48901), Vector3(1.64, 1.587, -0.855), Vector3(0, 0.288, 0.122)]
		if curve.point_count == 3:
			curve.remove_point(2)
		curve.set_point_position(0,data[0])
		curve.set_point_position(1,data[1])
		curve.set_point_out(0,data[2])
		curve.set_point_in(1,data[3])
		return
		
	if curve.point_count == 2:
		curve.add_point(Vector3(0,0,-5))
		
	
	if height == 0:
		data = [Vector3(0.000056, 1.39608, -2.43352), Vector3(0.000056, 0.987539, -2.65724), Vector3(0.000056, 0.729281, 0.620979), Vector3(0.000056, 0.570497, 1.02623)]
	elif height == 1:
		data = [Vector3(0, 4.32, -2.823), Vector3(0.000056, 2.52296, -1.7667), Vector3(0, 0, 0), Vector3(0.000056, 2.85315, 1.39473)]
	elif height == 2:
		data = [Vector3(0, 0.825, -2.823), Vector3(0.000056, 0.739877, -1.84035), Vector3(0.000056, 0.729281, 0.620979), Vector3(0, 0.448, 0.906)]
	elif height == 3:
		data = [Vector3(0.000056, 1.0091, -3.5284), Vector3(0.000056, 2.03342, -2.10995), Vector3(-0.000066, -0.00216, 0.122108), Vector3(0.000056, 2.30121, 2.13744)]
	
	curve.set_point_position(0,Vector3(0,0,5))
	curve.set_point_position(1,Vector3(0,0.1,-0.6))
	curve.set_point_position(2,Vector3(0,0,-5))
	curve.set_point_out(0,data[0])
	curve.set_point_out(1,data[1])
	curve.set_point_in(1,data[2])
	curve.set_point_in(2,data[3])

func flip():
	rotation_degrees.y += 180
	$PathFollow3D.progress_ratio = 0


func saveCurve():
	
	data.append(curve.get_point_position(0))
	data.append(curve.get_point_position(1))
	data.append(curve.get_point_out(0))
	data.append(curve.get_point_in(1))
	


func _on_character_body_3d_force_fast_path():
	height = 3


func _on_character_body_3d_force_normal_path():
	height = 0


func _on_character_body_3d_force_barely_path():
	height = 5


func _on_character_body_3d_force_slow_path():
	height = 1


func _on_character_body_3d_force_super_path():
	height = 2
