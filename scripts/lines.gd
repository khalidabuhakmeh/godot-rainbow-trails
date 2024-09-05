extends Node2D

var lines: Array[Line2D]

@export var max_points := 100

func _ready() -> void:
	for node in get_children():
		if node is Line2D:
			# allow each line to set position based in scene
			node.top_level = true
			# ignore the initial points because 
			# things are about to get really weird :)
			node.clear_points()
			lines.append(node)

func _physics_process(_delta: float) -> void:
	var point = global_position
	for line in lines:
		line.add_point(point)
		if line.points.size() > max_points:
			line.remove_point(0)
