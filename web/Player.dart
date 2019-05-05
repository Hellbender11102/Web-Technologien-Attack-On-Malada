import 'Actors.dart';
import 'Enemy.dart';
import 'Vector.dart';

class Player extends Actor{
  Player(double curr_x, double curr_y){
    this.curr_pos_X = curr_x;
    this.curr_pos_Y = curr_y;
    this.damage = 1;
    this.life = 6;
    this.vector = new Vector(0.0, 1.0);
  }
  //Player function to shoot enemy. Whether it hits or not is up to controller/world
  void shoot(Enemy enemy){
    enemy.life = enemy.life - this.damage;
  }

  String toString(){
    return "Player on position: $curr_pos_X  $curr_pos_Y";
  }
}