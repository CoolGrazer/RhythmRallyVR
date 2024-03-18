extends StaticBody3D

var velocity : Vector3

@onready var hand = get_node(get_path_to(get_parent()))
var lastPos = Vector3.ZERO
@onready var area3D = get_node("Area3D")

func _physics_process(_delta):
	velocity = lastPos - hand.global_position
	
	
	for x in area3D.get_overlapping_bodies():
		if !x == self:
			x.contact(velocity)
	
	
	lastPos = hand.global_position
