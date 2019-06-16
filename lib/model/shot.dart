
import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';

class Shot extends Actor{
  @override
  List<String> classes = ["shot"];

  Shot(var game,int id,double posX, double posY, double posX2, double posY2) : super(game, id,posX, posY, 4, 8, 1){
    speedX = (posX2 - posX) > 0 ? (posX2 - posX) /ticks :(posX2 - posX) /-ticks;
    speedY = posY2 - posY > 0 ? shotSpeed : -shotSpeed; //bestimmen der richtung in die der schuss fleigt
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