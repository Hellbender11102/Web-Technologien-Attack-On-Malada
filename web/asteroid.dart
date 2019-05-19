import 'dart:html';
import 'enemy.dart';

class Asteroid extends Enemy {
  var enemy = querySelector("#enemy_asteroid");
  var screen = querySelector("#screen");

  double ast_x;
  double ast_y;
  int life;
  bool dead = false;

  double get xPos => ast_x;

  double get yPos => ast_y;

  ImageElement asteroid = new ImageElement();

  Asteroid(int life, double x, double y) : super(0, 0.0, 0.0) {
    this.asteroid.src = "Assets/asteroid_fix.png";
    this.asteroid.className = "enemy_asteroid";
    this.asteroid.style.position = "absolute";
    this.asteroid.style.bottom = "${y}px";
    this.asteroid.style.left = "${x}px";
    this.screen.children.add(asteroid);

    this.life = life;
    ast_x = x;
    ast_y = y;
  }

  moveDown() {
    if ((ast_y - 1) > 0) {
      ast_y -= 1;
    } else {
      this.asteroid.src = "";
      dead = true;
    }
    this.asteroid.querySelector(".enemy_asteroid");
    this.asteroid.style.bottom = "${ast_y}px";
  }
}
