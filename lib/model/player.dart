import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/shot.dart';
import 'dart:math';

class Player extends Actor {
  bool _shotReady = true;
  @override
  List<String> classes = ["player"];

  ///Erstellt einen Spieler
  ///Die Zahl 56 ist die Breite des Spielers
  ///Die Zahl 27 ist die Höhe des Spielers
  ///Die Zahl 6 ist das maximale Leben des Spielers
  Player(var game, int id, double posX, double posY)
      : super(game, id, posX, posY, 56, 27, 6);
  List<int> firendlyId = List();
  Actor cross;
  double sinVal = 0; //Wird genutzt für Animation

  ///Move wird überschrieben, da der Player nur dem Fadenkreuz folgt
  @override
  void move() {
    posX = cross.posX + (cross.sizeX - sizeX) / 2;
    if (posX < 0) {
      posX = 0;
    }
    posY = sin(sinVal) * 10 + 30;
    sinVal >= 6.28 ? sinVal = 0.00 : sinVal += 0.01;
  }

  @override
  update() {
    tickCount++;
    _shotReady = tickCount % (tick * 0.75) == 0 || _shotReady ? true : false;
    super.update();
  }

  ///Erstellt einen Schuss, der in Richtung Fadenkreuz fliegt
  void shoot() {
    if(_shotReady) {
      int id = game.currentEntityID++;
      game.actors.add(Shot(game, id, posX + sizeX / 2,
          posY + sizeY / 2, cross.posX + cross.sizeX / 2, cross.posY)
        ..classes.add("friendlyFire")
        ..damage = this.damage);
      firendlyId.add(id);
      _shotReady = false;
    }
  }


  ///Überprüft, ob er dem Objekt Schaden machen darf und zieht dann beiden Objekten Leben ab
  @override
  void damageOnCollision(List<Actor> actors) {
    for(Actor a in actors) {
      if (collision(a) && !firendlyId.contains(a.id) && a != this) {
        a.life -=  damage;
        life -= a.damage;
      }
    }
  }
}
