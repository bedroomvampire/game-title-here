extends RigidBody3D

@export var collision: CollisionShape3D
@export var weight: float = 2

func _physics_process(delta):
    mass = collision.scale.length() * weight
