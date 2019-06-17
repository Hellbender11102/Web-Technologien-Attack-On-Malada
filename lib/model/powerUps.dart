import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/game.dart';

class PowerUps extends Actor {
  int type = 0;

  PowerUps(Game game, int id, double posX, double posY, double sizeX,
      double sizeY, int life)
      : super(game, id, posX, posY, 40, 40, 1) {
    damage = 0;
    classes.add('powerup');
  }

  @override
  void accelerate() {
    speedY = -1;
  }

  @override
  void damageOnCollision(List<Actor> actors) {
    for (Actor a in actors) {
      if (a.classes.contains("player")) {
        switch (type) {
          case 0:
            a.life = a.life > 9 ? 9 : a.life + 1;
            break;
          case 1:
            a.damage += 1;
            break;
          case 2:
            a.collisionDetect = false;
            break;
        }
      }
    }
  }
}
