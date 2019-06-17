import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/player.dart';
import 'package:dartmotion_master/model/shot.dart';

class Enemy extends Actor {
  @override
  List<String> classes = ["casual", "enemy"];

  ///Erstellt einen Enemy
  Enemy(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, damage)
      : super(game, id, posX, posY, sizeX, sizeY, life);

  @override
  update() {
    super.update();
    tickCount++;
    shootPlayer();
  }

  ///nimmt die X- und Y-Koordinate des Spielers und erstellt einen Schuss, der in die Richtung fliegt
  @override
  void shootPlayer() {
    Player a = game.player;
    if (tickCount % (tick * 10 ) == 0) {
      Shot shot = Shot(game, game.currentEntityID++, posX + sizeX / 2, posY + sizeY / 2,
          a.posX + a.sizeX / 2, a.posY)
        ..damage = this.damage
        ..classes.addAll(["enemyShot", "enemy"]);
      game.actors.add(shot);
      game.enemies.add(shot);
    }
  }

  ///Fliegt seitlich hin- und her, ändert die Richtung, wenn er am Bildschirmrand angekommen ist
  @override
  void accelerate() {
    if (posY < game.worldSizeY && posY >= game.screenSizeY - sizeY) {
      speedY = -0.25;
    } else if (posY < 0 + sizeY * 2) {
      speedY = 0.25;
    } else {
      speedY = speedY >= 0 ? 0.25 : -0.25;
    }
    if (posX > game.worldSizeX - sizeX) {
      speedX = -0.5;
    } else if (posX < 0 + sizeX) {
      speedX = 0.5;
    } else {
      speedX = speedX >= 0 ? 0.5 : -0.5;
    }
  }
}
