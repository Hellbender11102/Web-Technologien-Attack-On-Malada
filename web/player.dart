
import 'model/actors.dart';
import 'model/enemy.dart';
import 'model/vector.dart';
import 'dart:math';

class Player extends Actor{


  //viewranges for distance
  int renderDistance;
  int renderWidth;
  //bufferCap keeps unseeable enemies from rendering
  int bufferCap;



  Player(double curr_x, double curr_y){
    this.curr_pos_X = curr_x;
    this.curr_pos_Y = curr_y;
    this.damage = 1;
    this.life = 6;
    this.renderDistance = 15;
    this.renderWidth = 5;
    this.bufferCap = sqrt((this.renderDistance * this.renderDistance)+(this.renderWidth * this.renderWidth)).floor();
    this.vector = new Vector(0.0, 1.0);

  }
  //Player function to shoot enemy. Whether it hits or not is up to controller/world
  void shoot(Enemy enemy){
    enemy.life = enemy.life - this.damage;
  }

  String toString(){
    return "Player on position: $curr_pos_X  $curr_pos_Y";
  }

  Vector getVector(){
    return this.vector;
  }

  double distanceToPlayer(Enemy e){
    Vector vTemp = this.vector;
    vTemp.rotate(90);
    //Hierbei ist 5 die Breite des Casters (etwa der Bildschirm)
    double x1 = this.curr_pos_X + (vTemp.dx * this.renderWidth);
    double y1 = this.curr_pos_Y + (vTemp.dy * this.renderWidth);
    return vTemp.shortestDistance(x1, y1, this.renderDistance, e.curr_pos_X, e.curr_pos_Y);
  }

}