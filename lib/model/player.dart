import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/shot.dart';
import 'dart:math';

class Player extends Actor {
  @override
  List<String> classes = ["player"];

  Player(var game, int id, double posX, double posY)
      : super(game, id, posX, posY, 56, 27, 6);
  List<int> shotId = List();
  Actor cross;
  double sinVal = 0; //Wird genutzt für Animation

  ///move wird überschrieben da der player nur dem Fadenkreutz folgt
  @override
  void move() {
    posX = cross.posX + (cross.sizeX - sizeX) / 2;
    posY = sin(sinVal)*10+30;
    sinVal >= 6.28 ? sinVal = 0.00 : sinVal += 0.01 ;
  }

  ///erstellt einen schuss der in richtung fadenkreutz fliegt
  void shoot() {
    int id = game.currentEntityID++;
    game.actors.add(Shot(game, id, posX + sizeX / 2,
        posY + sizeY / 2, cross.posX + cross.sizeX / 2, cross.posY)
      ..classes.add("friendlyFire")
      ..damage = this.damage);
    shotId.add(id);
  }


  ///überprüft ob er dem objekt schaden machen darf und zieht dann beiden objekt leben ab
  @override
  void damageOnCollision(List<Actor> actors) {
    for(Actor a in actors) {
      if (collision(a) && !a.isDead && !shotId.contains(a.id) && a != this && !isDead) {
        a.life -=  damage;
        life -= a.damage;
      }
    }
  }
}
