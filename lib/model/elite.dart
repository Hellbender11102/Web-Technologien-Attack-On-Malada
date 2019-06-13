
import 'package:dartmotion_master/model/enemy.dart';

class Elite extends Enemy{
  Elite(var game,int id, double posX, double posY, double sizeX, double sizeY, int life,bool isHeavy,int damage) : super(game,id, posX, posY, sizeX, sizeY, life, isHeavy ,damage){
    classes.add("elite");
  }


  ///Elite gegner bekommen ein besonderes movment welches sich auf das Fadenkreuz bezieht
  @override
  void move() {
    double crossX = game.cross.posX;
    double crossY = game.cross.posY;

    if(crossX > posX -20){
      speedX +1;
    }
    if(crossX < posX +20){
      speedX -1;
    }
    if(crossY > posY -20){
      speedY +1;
    }
    if(crossY < posY +20){
      speedY -1;
    }
    if(posX +speedX > game.worldSizeX){
      posX - 100;
    }else if(posX +speedX < 0 ){
      posX +100;
    }
    if(posY +speedY > game.worldSizeY){
      posY - 100;
    }else if(posY +speedY < 0 ){
      posY +100;
    }
  }
}