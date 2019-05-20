import 'actors.dart';
import 'vector.dart';

abstract class Enemy extends Actor {
  Enemy(int life_start, double posX, double posY) {
    this.curr_pos_X = posX;
    this.curr_pos_Y = posY;
    this.life = life_start;
    this.vector = new Vector(1.0, 0.0);
    this.damage = 1;
    //Icon Image //TBD
  }
  double get xPos => curr_pos_X;

  double get yPos => curr_pos_Y;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curr_pos_X'] = curr_pos_X;
    data['curr_pos_Y'] = curr_pos_Y;
    data['life'] = life;
    data['damage'] = damage;
    return data;
  }
  void move(){
    this.curr_pos_X += this.vector.dx;
    this.curr_pos_Y += this.vector.dy;
  }

}
