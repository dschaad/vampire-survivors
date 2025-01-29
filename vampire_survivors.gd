extends Node2D

func _ready() -> void:
	for i in range(50):
		generate_tree()

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	new_mob.add_to_group("mobs")
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("mobs").size() <= 100:
		spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func generate_tree():
	var new_tree = preload("res://tree.tscn").instantiate()
	
	var x = randi_range(-2000, 2000)
	var y = randi_range(-2000, 2000)
	
	new_tree.global_position = Vector2(x, y)
	
	add_child(new_tree)
