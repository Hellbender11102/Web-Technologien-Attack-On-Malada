
import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/player.dart';
import 'package:dartmotion_master/model/shot.dart';

class Enemy extends Actor{
  bool isHeavy;
  int damage;
  Enemy(var game,int id, double posX, double posY, double sizeX, double sizeY, int life, this.isHeavy,this.damage) : super(game,id, posX, posY, sizeX, sizeY, life){
    classes.add("casual");
  }
  
  void shootPlayer(){
    Player a = game.player;
    game.actors.add(Shot(game,game.currentEntityID++,posX,posY,a.posX,a.posY)..damage = this.damage);
    game.enemyShots.add(game.currentEntityID);
  }

}