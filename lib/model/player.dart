import 'actors.dart';
import 'enemy.dart';
import 'vector.dart';
import 'asteroid.dart';
import 'dart:html';
import 'dart:math';
import 'mini_map.dart';

class Player extends Actor {
 //viewranges for distance
 static final int renderDistance = 30, renderWidth = 10;

 //bufferCap keeps unseeable enemies from rendering
 int bufferCap = sqrt((renderDistance * renderDistance)+(renderWidth * renderWidth)).floor();

  ///Constructor for the player
 Player(double curr_x, double curr_y) : super(curr_x, curr_y){
    this.damage = 1;
    this.life = 6;
    this.vector = new Vector(0.0, 1.0);
  }


  get style => this.style;
  
  
  ///Shoot function
  void shoot(List<Enemy> enemyList, var cross, MiniMap mMap) {
    cross = querySelector(".cross");
    var rectC = cross.getBoundingClientRect();

    for (int k = 0; k < enemyList.length; k++) {
      var rectA = enemyList[k].getImage().getBoundingClientRect();
      var overlapAC = !(rectA.right < rectC.left ||
          rectA.left > rectC.right ||
          rectA.bottom < rectC.top ||
          rectA.top > rectC.bottom);
      if (overlapAC) {
        enemyList[k].life -= this.damage;
        if(enemyList[k].life <= 0){
          enemyList[k].dead = true;
          enemyList[k].getImage().remove();
          enemyList.removeAt(k);
          mMap.deletDot(k);
        }
      }
    }
  }

  String toString() {
    return "Player on position: $curr_pos_X  $curr_pos_Y";
  }
  Vector getVector(){
    return this.vector;
  }

  /// We get the euclidian distance to the Player with this function
  /// This is needed for the hypothenuse in other functions later on
  /// For simplicity we use an enemy in this function, another one for position will be added soon
  double distanceToPlayer4enemy(Enemy e){
    Vector vTemp = this.vector;
    vTemp.rotate(90);
    //Whereas 5 is the width of the caster (for example view width)
    double x1 = this.curr_pos_X + (vTemp.dx * renderWidth);
    double y1 = this.curr_pos_Y + (vTemp.dy * renderWidth);
    return vTemp.shortestDistance(x1, y1, renderDistance, e.curr_pos_X, e.curr_pos_Y);
  }

  /// We get the euclidian distance to the Player with this function
  /// This is needed for the hypothenuse in other functions later on
  double distanceToPlayer4coord(double curr_pos_x, double curr_pos_y){
    Vector vTemp = this.vector;
    vTemp.rotate(90);
    //Whereas 5 is the width of the caster (for example view width)
    double x1 = this.curr_pos_X + (vTemp.dx * renderWidth);
    double y1 = this.curr_pos_Y + (vTemp.dy * renderWidth);
    return vTemp.shortestDistance(x1, y1, renderDistance, curr_pos_X, curr_pos_Y);
  }
}
