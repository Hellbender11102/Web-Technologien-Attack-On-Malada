import 'package:dartmotion_master/model/shot.dart';

import 'actors.dart';
import 'vector.dart';
import 'dart:html';



abstract class Enemy extends Actor {
  bool dead = false;
  ImageElement image;


  Enemy(int life_start, double posX, double posY) : super(posX, posY) {
    this.life = life_start;
    this.vector = new Vector(1.0, 0.0);
    this.damage = 1;
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
  @override void move(){
    this.curr_pos_X += this.vector.dx;
    this.curr_pos_Y += this.vector.dy;
  }

  @override ImageElement getImage(){
    return this.image;
  }

  bool isDead(){
    return dead;
  }

  Shot shoot(){}

  bool isInView(){
    return true;
  }

  void cleverMove(int posX, int posY){}
}
