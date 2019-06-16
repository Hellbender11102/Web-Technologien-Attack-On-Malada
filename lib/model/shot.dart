
import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'dart:math' as Math;

class Shot extends Actor{
  @override
  List<String> classes = ["shot"];

  Shot(var game,int id,double posX, double posY, double posX2, double posY2) : super(game, id,posX, posY, 4, 8, 1){
    speedX = (posX2 - posX) * (1 / (Math.sqrt(posX2) + Math.sqrt(posX)));
    speedY = (posY2 - posY) * (1 / (Math.sqrt(posY2) + Math.sqrt(posY)));
  }
  //muss überschrieben werden da ein schuss keine beschleunigung erfährt
  @override
  void accelerate(){
    if (posY + speedY <=  0 || posY + speedY>= game.worldSizeY || posX+ speedX <=  0 || posX+ speedX >= game.worldSizeX + game.cross.sizeY / 2){
      life = 0;
      collisionDetect = false;
    }
    speedX;
    speedY;
  }

}