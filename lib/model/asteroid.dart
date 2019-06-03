import 'dart:html';
import 'enemy.dart';
import 'dart:math';

class Asteroid extends Enemy {
  var enemy = querySelector("#enemy_asteroid");
  var screen = querySelector("#screen");
  double _height = 20;
  double _width = 20;

  int life, x;
  bool dead = false;

  ImageElement asteroid = new ImageElement();

  Asteroid(double x, double y) : super(1, x, y) {
    this.asteroid.src = "Assets/asteroid.png";
    this.asteroid.className = "enemy_asteroid";
    this.asteroid.style.position = "absolute";
    this.asteroid.style.bottom = "${y}px";
    this.asteroid.style.left = "${x}px";
    this.screen.children.add(asteroid);

    this.life = 1;
  }


  @override void move() {
    if ((curr_pos_Y - 3) > 0) {
      curr_pos_Y -= 3;
    } else {
      dead = true;
    }
    if(curr_pos_Y <= screen.clientHeight){
      _height += 0.3;
      _width += 0.3;
      //x++;
    }

    this.asteroid.querySelector(".enemy_asteroid");
    this.asteroid.style.bottom = "${curr_pos_Y}px";
    this.asteroid.width = _width.floor();
    this.asteroid.height = _height.floor();
  }

  @override ImageElement getImage(){
    return this.asteroid;
  }
}
