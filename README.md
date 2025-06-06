# hello_world
 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a/README.md b/README.md
index 50954d9b9266d6c3eff76c0fd87a1cb62c87d481..0aaea46c0af5657f2cf8f9eb20f9028b79fd9b21 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,36 @@
-# hello_world
+# Simple Vice City Style Game
+
+This repository contains a small demo game built with **pygame**. The game is a
+minimal top-down sandbox reminiscent of classic open-world games. You can walk
+around as a character, enter a car and drive it around a scrolling map. A
+simple day/night cycle darkens the screen over time.
+
+## Requirements
+
+- Python 3.8+
+- `pygame` package
+
+Install dependencies with:
+
+```bash
+pip install pygame
+```
+
+## Running the Game
+
+After installing the requirements, start the game with:
+
+```bash
+python main.py
+```
+
+When you start the game you control the player on foot using the arrow keys. If
+you approach the car and press `E`, you enter it and can drive. Press `E` again
+to exit the vehicle. `UP` and `DOWN` accelerate/brake while `LEFT` and `RIGHT`
+steer. Close the window or press the close button to exit.
+
+The repository also includes `Vice80City.gd`, a Godot version of this logic if
+you prefer experimenting with GDScript.
+
+This demo is intentionally very small but can serve as a starting point for a
+larger project.
 
EOF
)
