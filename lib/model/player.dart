import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/shot.dart';

class Player extends Actor {
  @override
  List<String> classes = ["player"];

  Player(var game, int id, double posX, double posY)
      : super(game, id, posX, posY, 56, 27, 6);
  List<int> shotId = List();
  Actor cross;

  ///move wird überschreieben da der player nur dem Fadenkreutz folgt
  @override
  void move() {
    posX = cross.posX + (cross.sizeX - sizeX) / 2;
  }

  ///erstellt einen schuss der in richtung fadenkreutz fliegt
 @override
  void shoot() {
    int id = game.currentEntityID++;
    game.actors.add(Shot(game, id, posX + sizeX / 2,
        posY + sizeY / 2, cross.posX + cross.sizeX / 2, cross.posY)
      ..classes.add("friendlyFire")
      ..damage = this.damage);
    shotId.add(id);
  }

  @override
  void damageOnCollision(List<Actor> actors) {
    for(Actor a in actors) {
      if (collision(a) && !a.isDead && !shotId.contains(a.id) && a != this && !isDead) {
        a.life - this.damage;
        life -= a.damage;
      }
    }
  }
}
