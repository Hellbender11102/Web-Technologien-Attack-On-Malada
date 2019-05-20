import 'dart:html';
import 'enemy.dart';

class Asteroid extends Enemy {
  var enemy = querySelector("#enemy_asteroid");
  var screen = querySelector("#screen");
  double _height = 40;
  double _width = 40;

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

  
  move() {
    if ((curr_pos_Y - 3) > 0) {
      curr_pos_Y -= 3;
    } else {
      dead = true;
    }
    this.asteroid.querySelector(".enemy_asteroid");
    this.asteroid.style.bottom = "${curr_pos_Y}px";
    this.asteroid.width = _width.floor();
    this.asteroid.height = _height.floor();
    _width += 0.2;
    _height += 0.2;
  }
}
