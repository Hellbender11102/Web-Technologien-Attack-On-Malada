import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/player.dart';
import 'package:dartmotion_master/model/shot.dart';

class Enemy extends Actor {
  bool isHeavy;
  int damage;

  @override
  List<String> classes = ["casual"];

  Enemy(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, this.isHeavy, this.damage)
      : super(game, id, posX, posY, sizeX, sizeY, life);

  ///nimmt die x und y coordinate des spielers und erstellt einen schuss der in die richtung fliegt
  @override
  void shootPlayer() {
    int id = game.currentEntityID++;
    Player a = game.player;
    game.actors.add(Shot(game, id, posX, posY, a.posX, a.posY)
      ..damage = this.damage
      ..classes.add("enemyShot"));
    game.enemyShots.add(id);
  }
}
