import 'Actors.dart';
import 'Vector.dart';

abstract class Enemy extends Actor{
  Enemy(int life_start, double posX, double posY){
    this.curr_pos_X = posX;
    this.curr_pos_Y = posY;
    this.life = life_start;
    this.vector = new Vector(1.0,0.0);
    this.damage = 1;
    //Icon Image //TBD

  }
}