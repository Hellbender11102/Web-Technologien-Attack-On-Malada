import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/game.dart';

class HealthUp extends Actor {

  HealthUp(Game game, int id, double posX, double posY)
      : super(game, id, posX, posY, 40, 40, 1) {
    damage = 0;
    classes.add('healthUp');
  }

  @override
void accelerate() {
    speedY = -0.75;

  }

  @override
  void damageOnCollision(List<Actor> actors) {
    for (Actor a in actors) {
      if (a.classes.contains("player") && a.collision(a)) {
        a.life += a.life >= 9 ? 0 : 1;
        this.life =0;
      }
    }
  }
}
