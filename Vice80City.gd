 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/Vice80City.gd
index 0000000000000000000000000000000000000000..cb3a8e5bb81343c10d7428d9274e96e0466e5841 100644
--- a//dev/null
+++ b/Vice80City.gd
@@ -0,0 +1,92 @@
+# Vice80City.gd - Fichier principal Godot (GDScript)
+# Description : prototype de jeu open-world inspiré de Vice City
+# Ce code simplifie la logique du personnage, de la voiture et du cycle jour/nuit
+
+extends Node3D
+
+@onready var player = $Player
+@onready var car = $Car
+@onready var sun = $WorldEnvironment/SunLight
+@onready var music = $AudioStreamPlayer
+@onready var cam = $Player/Camera3D
+@onready var sky = $WorldEnvironment
+
+var is_night = false
+var time = 0.0
+var in_car = false
+
+func _ready():
+    music.play()
+    sun.light_energy = 1.0
+    sky.environment.background_color = Color(0.7, 0.9, 1.0)
+
+func _process(delta):
+    _handle_day_night_cycle(delta)
+    if in_car:
+        _drive_car(delta)
+    else:
+        _control_player(delta)
+
+func _handle_day_night_cycle(delta):
+    time += delta * 0.05
+    var angle = fmod(time, PI * 2)
+    sun.rotation.x = angle
+    if angle > PI:
+        # nuit
+        sun.light_energy = 0.2
+        sky.environment.background_color = Color(0.05, 0.05, 0.1)
+        is_night = true
+    else:
+        # jour
+        sun.light_energy = 1.0
+        sky.environment.background_color = Color(0.7, 0.9, 1.0)
+        is_night = false
+
+func _control_player(delta):
+    var dir = Vector3.ZERO
+    if Input.is_action_pressed("move_forward"):
+        dir -= player.global_transform.basis.z
+    if Input.is_action_pressed("move_backward"):
+        dir += player.global_transform.basis.z
+    if Input.is_action_pressed("move_left"):
+        dir -= player.global_transform.basis.x
+    if Input.is_action_pressed("move_right"):
+        dir += player.global_transform.basis.x
+
+    dir = dir.normalized() * 5
+    player.move_and_slide(dir, Vector3.UP)
+
+    if player.global_transform.origin.distance_to(car.global_transform.origin) < 3.0 and Input.is_action_just_pressed("interact"):
+        _enter_car()
+
+func _drive_car(delta):
+    var input = Vector3.ZERO
+    if Input.is_action_pressed("move_forward"):
+        input.z -= 1
+    if Input.is_action_pressed("move_backward"):
+        input.z += 1
+    if Input.is_action_pressed("move_left"):
+        car.rotate_y(deg_to_rad(-1))
+    if Input.is_action_pressed("move_right"):
+        car.rotate_y(deg_to_rad(1))
+
+    car.translate(car.global_transform.basis.z * input.z * delta * 10)
+
+    if Input.is_action_just_pressed("interact"):
+        _exit_car()
+
+func _enter_car():
+    in_car = true
+    player.visible = false
+    cam.set_owner(car)
+    cam.global_transform = car.global_transform.translated(Vector3(0, 2, -6))
+    car.add_child(cam)
+
+func _exit_car():
+    in_car = false
+    player.global_transform.origin = car.global_transform.origin + Vector3(2, 0, 0)
+    player.visible = true
+    add_child(cam)
+    cam.set_owner(player)
+    cam.global_transform = player.global_transform.translated(Vector3(0, 2, -4))
+    player.add_child(cam)
 
EOF
)
