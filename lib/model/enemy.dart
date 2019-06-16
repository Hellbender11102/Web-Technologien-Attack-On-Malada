import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/player.dart';
import 'package:dartmotion_master/model/shot.dart';

class Enemy extends Actor {
  int damage;
  @override
  List<String> classes = ["casual"];

  Enemy(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, this.damage)
      : super(game, id, posX, posY, sizeX, sizeY, life);

  ///nimmt die x und y coordinate des spielers und erstellt einen schuss der in die richtung fliegt
  @override
  void shootPlayer() {
    int id = game.currentEntityID++;
    Player a = game.player;
    game.actors.add(Shot(game, id, posX + sizeX /2, posY + sizeY/2, a.posX + a.sizeX /2, a.posY)
      ..damage = this.damage
      ..classes.add("enemyShot"));
    game.enemyShots.add(id);
  }
}
