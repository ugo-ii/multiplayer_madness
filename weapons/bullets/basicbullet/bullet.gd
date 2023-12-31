class_name Bullet extends StaticBody2D

@export var smoke_scene: PackedScene
@export var fall_scene: PackedScene

var speed = 0
var direction = Vector2(0,0)
var bullet_range = 0
var start_pos: Vector2
var id: int
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Globals.is_server():
		return
		
	if bullet_range != 0:
		if global_position.distance_to(start_pos) > bullet_range:
			if fall_scene != null:
				var fall = fall_scene.instantiate() as GPUParticles2D
				fall.global_position = global_position
				fall.rotation = rotation
				
				get_tree().root.add_child(fall)
			queue_free()
	var collision_result = move_and_collide(direction * speed * delta)
	if collision_result != null:
		var other = collision_result.get_collider() as Node
		
		if other is TileMap:
			if smoke_scene != null:
				var smoke = smoke_scene.instantiate() as GPUParticles2D
				smoke.rotation = collision_result.get_normal().angle()
				smoke.global_position = collision_result.get_position()
				get_tree().root.add_child(smoke)
			queue_free()
		pass
		
func fire(new_start_pos, new_direction, new_speed):
	self.global_position = new_start_pos
	self.start_pos = new_start_pos
	self.speed = new_speed
	self.direction = new_direction
