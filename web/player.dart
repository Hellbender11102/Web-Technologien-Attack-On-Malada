import 'actors.dart';
import 'enemy.dart';
import 'vector.dart';

class Player extends Actor{
  //viewrange for distance
  int renderDistance;
  Player(double curr_x, double curr_y){
    this.curr_pos_X = curr_x;
    this.curr_pos_Y = curr_y;
    this.damage = 1;
    this.life = 6;
    this.renderDistance = 10;
    this.vector = new Vector(0.0, 1.0);
  }
  //Player function to shoot enemy. Whether it hits or not is up to controller/world
  void shoot(Enemy enemy){
    enemy.life = enemy.life - this.damage;
  }

  String toString(){
    return "Player on position: $curr_pos_X  $curr_pos_Y";
  }

  //Hier später noch check für x * dx > 0 um nur die richtige Richtung zu bekommen
  double distanceToPlayer(Enemy e){
    Vector vTemp = this.vector;
    vTemp.rotate(90);
    //Hierbei ist 5 die Breite des Casters (etwa der Bildschirm)
    double x1 = this.curr_pos_X - (vTemp.dx * 5);
    double y1 = this.curr_pos_Y - (vTemp.dy * 5);
    return vTemp.shortestDistance(x1, y1, 10, e.curr_pos_X, e.curr_pos_Y);
  }

  //
  double offSetFromMiddle(Enemy e){
    return this.vector.shortestDistance(this.curr_pos_X, this.curr_pos_Y, this.renderDistance, e.curr_pos_X, e.curr_pos_Y);
  }
  
}