extends Node3D

var active: bool
var click_timer: float
var physobj
@export var player: CharacterBody3D
@export var raycast: RayCast3D
@export var joint: Generic6DOFJoint3D
@export var physmarker: Marker3D
@export var physref2: Node3D
@export var phys_static: StaticBody3D
var physlock: bool
var calc_debug
@export var physpull: float = 12
@export var physrot: float = 0.5
@export var cursor: Node3D


func _ready():
    pass



func _process(delta):
    if visible:
        active = true
    else:
        active = false

func _physics_process(delta):
    click_timer += 0.5 * delta
    cursor.global_position = raycast.get_collision_point()

    if active:
        hold_physobj(physobj, delta)
        _interaction()

        if Input.is_action_just_pressed("interact"):
            if physobj && click_timer >= 0.1:
                drop_physobj()
        if Input.is_action_just_pressed("fire"):
            if physobj && click_timer >= 0.1:
                throw_physobj()

        if physobj:
            if Input.is_action_just_pressed("scale_up"):
                physobj.collision.scale += Vector3(0.1, 0.1, 0.1)
                physobj.collision.scale = clamp(physobj.collision.scale, Vector3(0.5, 0.5, 0.5), Vector3(3, 3, 3))
            elif Input.is_action_just_pressed("scale_down"):
                physobj.collision.scale -= Vector3(0.1, 0.1, 0.1)
                physobj.collision.scale = clamp(physobj.collision.scale, Vector3(0.5, 0.5, 0.5), Vector3(3, 3, 3))

func _interaction():
    if raycast.is_colliding():
        if raycast.get_collider().has_node("Item"):

            if Input.is_action_just_pressed("fire"):
                pass
            else:

                pass
        elif raycast.get_collider().has_node("PhysObj"):

            if Input.is_action_just_pressed("fire"):
                if !physobj && !player.physobj:
                    grab_physobj(raycast.get_collider())
                    click_timer = 0.0
                else:
                    drop_physobj()
        else:

            pass
    else:

        pass

func grab_physobj(object):
    if object && object is RigidBody3D:
        physobj = object
        get_physobj_rotation()

func get_physobj_rotation():

    pass

func drop_physobj():
    if physobj:
        physobj = null
        joint.node_b = joint.get_path()

func hold_physobj(object, delta):
    if object != null:
        var a = object.global_position
        var b = physmarker.global_position
        var c = a.distance_to(b)
        var calc = (a.direction_to(b)) * physpull * c
        physref2.look_at(object.global_position)
        var d = physref2.global_position
        var e = a.distance_to(d)
        calc_debug = e
        joint.node_b = physobj.get_path()
        object.set_linear_velocity(calc)
        object.angular_velocity = lerp(object.angular_velocity, Vector3.ZERO, delta * 10)



func rotate_physobj(event):
    if physobj && event is InputEventMouseMotion:
        phys_static.rotate_x(deg_to_rad( - event.relative.y * physrot))
        phys_static.rotate_y(deg_to_rad(event.relative.x * physrot))

func throw_physobj():
    var knockback = (global_position - physobj.global_position) * 8
    joint.node_b = joint.get_path()
    physobj.apply_central_impulse( - knockback)

    physobj = null
