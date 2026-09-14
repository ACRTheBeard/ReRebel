extends Node2D
## Deep-space backdrop: a far starfield and nebula wash behind a baked
## spiral-galaxy image the map centers on the displayed sectors, so the
## sectors read as part of the galaxy. Field layout is seeded; the galaxy
## art itself is a checked-in PNG (see /tmp/make_galaxy.py generator).

const GLOW_SHELLS := 10
## Fraction of the texture half-width where the arm tips sit.
const IMAGE_RADIUS_FRAC := 0.85

var _stars: Array = []
var _nebulae: Array = []
var _galaxy := {}
var _sprite: Sprite2D


func _ready() -> void:
	var cfg := GalaxyData.backdrop()
	var rng := RandomNumberGenerator.new()
	rng.seed = int(cfg["seed"])
	var tint_a: Color = cfg["star_tint_a"]
	var tint_b: Color = cfg["star_tint_b"]
	for i in range(int(cfg["star_count"])):
		var bright := 0.25 + 0.75 * rng.randf()
		_stars.append({
			"u": Vector2(rng.randf(), rng.randf()),
			"r": 1.0 + 1.4 * rng.randf(),
			"c": tint_a.lerp(tint_b, rng.randf()) * bright,
		})
	var nebula_cols: Array = [cfg["nebula_a"], cfg["nebula_b"], cfg["nebula_a"].lerp(cfg["nebula_b"], 0.5)]
	for i in range(nebula_cols.size()):
		_nebulae.append({
			"u": Vector2(rng.randf(), rng.randf()),
			"r": 0.25 + 0.25 * rng.randf(),
			"c": nebula_cols[i],
		})
	_sprite = Sprite2D.new()
	_sprite.name = "GalaxySprite"
	var tex := load(str(cfg["galaxy_image"])) as Texture2D
	if tex == null:
		push_warning("Missing galaxy art: %s" % cfg["galaxy_image"])
	else:
		_sprite.texture = tex
	add_child(_sprite)
	get_tree().root.size_changed.connect(queue_redraw)


## Center and radius arrive in display pixels from the map, which knows
## where the sectors landed after its transform.
func build_galaxy(center: Vector2, radius: float) -> void:
	_galaxy = {"center": center, "radius": radius}
	if _sprite.texture != null:
		var half_px := float(_sprite.texture.get_width()) * 0.5 * IMAGE_RADIUS_FRAC
		var s := radius / half_px
		_sprite.position = center
		_sprite.scale = Vector2(s, s)
	queue_redraw()


func _draw() -> void:
	var size := get_viewport_rect().size
	if size.x <= 0.0 or size.y <= 0.0:
		return
	for n in _nebulae:
		var center: Vector2 = (n["u"] as Vector2) * size
		var radius := float(n["r"]) * size.y
		var base: Color = n["c"]
		for i in range(GLOW_SHELLS):
			var f := 1.0 - float(i) / float(GLOW_SHELLS)
			draw_circle(center, radius * f, Color(base.r, base.g, base.b, 0.05 * f))
	for s in _stars:
		draw_circle((s["u"] as Vector2) * size, float(s["r"]), s["c"])
