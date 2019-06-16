
import 'package:dartmotion_master/model/enemy.dart';

class Boss extends Enemy{


  Boss(var game,int id, double posX, double posY, double sizeX, double sizeY, int life,int damage) : super(game,id, posX, posY, sizeX, sizeY, life ,damage){
    classes.add("boss");
  }
}