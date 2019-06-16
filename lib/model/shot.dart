
import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'dart:math';

class Shot extends Actor{
  @override
  List<String> classes = ["shot"];

  Shot(var game,int id,double posX, double posY, double posX2, double posY2) : super(game, id,posX, posY, 4, 8, 1){
    print(posX2 - posX);
    print(posY2 - posY);
    speedX = (posX2 - posX) / ticks;
    speedY = (posY2 - posY) / ticks;
  }
  //muss überschrieben werden da ein schuss keine beschleunigung erfährt
  @override
  void accelerate(){
    if (posY <=  0 || posY >= game.worldSizeY || posX <=  0 || posX >= game.worldSizeX + game.cross.sizeY / 2){
      life = 0;
      collisionDetect = false;
    }
    speedX;
    speedY;
  }

}