import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/game.dart';

class HealthUp extends Actor {
  ///Erstellt ein HealthUp
  HealthUp(Game game, int id, double posX, double posY)
      : super(game, id, posX, posY, 40, 40, 1) {
    damage = 0;
    classes.add('healthUp');
  }

  ///HealthUps fallen langsam in einer geraden Linie herunter, ähnlich wie die Asteroiden.
  @override
  void accelerate() {
    speedY = -0.5;
    if (posY + speedY <= 0) {
      life = 0;
      collisionDetect = false;
    }
  }

  ///Überprüft, ob der Spieler bereits maximales Leben + Schilde hat.
  ///Wenn ja, passiert nichts.
  ///Wenn nein, füge dem Spieler ein Leben hinzu.
  @override
  void damageOnCollision(List<Actor> actors) {
    for (Actor a in actors) {
      if (a.classes.contains("player") && collision(a)) {
        if(a.life < 9){
          a.life = a.life +1;
          life= 0;
        }
      }
    }
  }
}
