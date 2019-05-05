import 'Vector.dart';

abstract class Actor{
  
  //Vector is for movement
  Vector vector;

  //Curr positions for actual placement
  double curr_pos_X;
  double curr_pos_Y;

  //damage is put individually
  int damage;

  //lifes to work with. Below 0 shall kill the Object
  int life;

  //Icon image; //TBD

  //simple function to move. Shall not be used by the asteroid
  void move(){
    this.curr_pos_X += this.vector.dx;
    this.curr_pos_Y += this.vector.dy;
  }

  double get X => this.curr_pos_X;

  double get Y => this.curr_pos_Y;
}