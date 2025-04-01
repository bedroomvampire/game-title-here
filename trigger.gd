extends CSGBox3D

var has_triggered: bool

func _process(delta):
    if has_triggered:
        visible = true
    else:
        visible = false


func _has_detected(bool):
    if true:
        has_triggered = true
    else:
        has_triggered = false
