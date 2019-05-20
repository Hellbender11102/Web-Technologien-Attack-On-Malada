import 'actors.dart';
import 'enemy.dart';
import 'vector.dart';
import 'asteroid.dart';
import 'dart:html';

class Player extends Actor {
  Player(double curr_x, double curr_y) {
    this.curr_pos_X = curr_x;
    this.curr_pos_Y = curr_y;
    this.damage = 1;
    this.life = 6;
    this.vector = new Vector(0.0, 1.0);
  }
  //Player function to shoot enemy. Whether it hits or not is up to controller/world
  bool shoot(List<Asteroid> enemyList, var cross) {
    cross = querySelector(".cross");
    var rectC = cross.getBoundingClientRect();

    for (int k = 0; k < enemyList.length; k++) {
      var rectA = enemyList[k].asteroid.getBoundingClientRect();
      var overlapAC = !(rectA.right < rectC.left ||
          rectA.left > rectC.right ||
          rectA.bottom < rectC.top ||
          rectA.top > rectC.bottom);
      if (overlapAC) {
        enemyList[k].dead = true;
        enemyList[k].asteroid.src = "";
        enemyList.removeAt(k);
        return true;
      }
    }
    return false;
  }

  String toString() {
    return "Player on position: $curr_pos_X  $curr_pos_Y";
  }
}
