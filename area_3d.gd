extends Area3D

@export var hole: Marker3D
var thing = preload("res://rigid_body_3d_3.tscn")


func _ready():
    pass



func _process(delta):
    pass


func _on_body_entered(body):
    body.queue_free()
    var ins = thing.instantiate()
    add_child(ins)
    ins.global_position = hole.global_position
