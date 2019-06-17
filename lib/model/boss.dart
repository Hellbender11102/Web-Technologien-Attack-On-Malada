import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/shot.dart';

class Boss extends Enemy {
  Boss(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, int damage)
      : super(game, id, posX, posY, sizeX , sizeY, life, damage) {
    classes.add("boss");
  }

  @override
  void shootPlayer() {
    super.shootPlayer();
    var a = game.player;
    if (tickCount % (tick * 5) == 0) {
      Shot shot = Shot(game, game.currentEntityID++, posX + sizeX / 2,
          posY + sizeY / 2, a.posX + a.sizeX * 3 / 2, a.posY)
        ..damage = this.damage
        ..classes.addAll(["enemyShot", "enemy"]);
      game.actors.add(shot);
      game.enemies.add(shot);
      shot = Shot(game, game.currentEntityID++, posX + sizeX / 2,
          posY + sizeY / 2, a.posX - a.sizeX * 3 / 2, a.posY)
        ..damage = this.damage
        ..classes.addAll(["enemyShot", "enemy"]);
      game.actors.add(shot);
      game.enemies.add(shot);
    }
  }
  @override
  void accelerate() {
    super.accelerate();
  }
  @override
  double keepInBounds(double speed, double pos, double max) {
    if (pos + speed > max) {
      pos = max - 25;
    } else if (pos + speed <= game.worldSizeY / 2) {
      pos -= speed;
    } else {
      pos += speed;
    }
    return pos;
  }
}
