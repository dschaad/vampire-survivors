extends CharacterBody2D

signal health_depleted

signal level_up

var health = 100.0
var xp = 0
var level = 0
var xp_to_next_level = 100
var bullet_damage = 1
var speed = 600
var regen_rate = 0.1

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()

	const DAMAGE_RATE = 10.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%Health.value = health
		
		if health <= 0.0:
			health_depleted.emit()

func gain_exp():
	xp += 100
	
	if xp >= xp_to_next_level:
		increase_level()
	
	%Experience.value = xp
	%Level.text = str(level)
	
func increase_level():
	xp -= xp_to_next_level
	level += 1
	bullet_damage += 1
	xp_to_next_level += 50
	speed += 10
	regen_rate += 0.1
	%Experience.max_value = xp_to_next_level

func _on_regen_timeout() -> void:
	health += regen_rate
	%Health.value = health
