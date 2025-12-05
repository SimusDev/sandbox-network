@static_unload
extends RefCounted
class_name SR_Collisions

const MAX_LAYERS: int = 32

enum LAYERS {
	WORLD = 1,
	ENTITY,
	ZONE,
}

static func clear_body_collisions(body: Variant) -> void:
	var i: int = MAX_LAYERS
	
	while (i > 0):
		body.set_collision_layer_value(i, false)
		body.set_collision_mask_value(i, false)
		i -= 1
	


static func set_body_collision(body: Variant, layers: LAYERS, layer: bool = true, mask: bool = true) -> void:
	body.set_collision_layer_value(layers, layer)
	body.set_collision_mask_value(layers, mask)
