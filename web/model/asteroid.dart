import 'dart:html';
import 'enemy.dart';

class Asteroid extends Enemy {
  var enemy = querySelector("#enemy_asteroid");
  var screen = querySelector("#screen");

  int life;
  bool dead = false;


  ImageElement asteroid = new ImageElement();

  Asteroid(int life, double x, double y) : super(life, x, y) {
    this.asteroid.src = "Assets/asteroid_fix.png";
    this.asteroid.className = "enemy_asteroid";
    this.asteroid.style.position = "absolute";
    this.asteroid.style.bottom = "${y}px";
    this.asteroid.style.left = "${x}px";
    this.screen.children.add(asteroid);

    this.life = life;
  }
  Asteroid.fromJson(Map<String, dynamic> json) : super(json['life'], json['curr_pos_X'], json['curr_pos_Y']) {
    this.life = json['life'];
  }


  moveDown() {
    if ((curr_pos_Y - 1) > 0) {
      curr_pos_Y -= 1;
    } else {
      this.asteroid.src = "";
      dead = true;
    }
    this.asteroid.querySelector(".enemy_asteroid");
    this.asteroid.style.bottom = "${curr_pos_Y}px";
  }
}
