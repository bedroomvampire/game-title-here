extends RayCast3D

@export var shape_detection: String
var detected: bool

signal has_detected(bool: bool)

func _physics_process(delta):
    if get_collider():
        if get_collider().has_node(shape_detection):
            detected = true
            emit_signal("has_detected", true)
    else:
        detected = false
