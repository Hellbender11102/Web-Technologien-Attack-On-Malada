import 'vector.dart';
import 'dart:html';

 abstract class Actor{
  Actor(this.curr_pos_X,this.curr_pos_Y);
  //Vector is for movement
  Vector vector;
  ImageElement image;

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
  }

  ImageElement getImage() {
    return this.image;
  }

  double get X => this.curr_pos_X;

  double get Y => this.curr_pos_Y;
}