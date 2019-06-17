import 'dart:io';

import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/shot.dart';
import 'dart:math';

class Player extends Actor {
  bool _shotReady = true;
  @override
  List<String> classes = ["player"];

  ///konstruktor für ein Player
  ///var game ist das Aktuelle spiel
  ///int id ist eine einzigartiger id um diesen im dom zu verwalten
  ///double posX ist die aktuelle position auf der X kooridnate
  ///double posY ist die aktuelle position auf der Y kooridnate
  ///Die zahl 56 ist die breite des Spielers
  ///Die zahl 27 ist die höhe des Spielers
  ///Die zahl 6 ist das maximale Leben des Spielers
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
  @override
  update() {
    tickCount++;
    _shotReady = tickCount % (tick * 0.75) == 0 || _shotReady ? true : false;
     super.update();
  }

  ///erstellt einen schuss der in richtung fadenkreutz fliegt
  void shoot() {
    if(_shotReady) {


      int id = game.currentEntityID++;
      game.actors.add(Shot(game, id, posX + sizeX / 2,
          posY + sizeY / 2, cross.posX + cross.sizeX / 2, cross.posY)
        ..classes.add("friendlyFire")
        ..damage = this.damage);
      shotId.add(id);
      _shotReady = false;
    }
  }


  ///überprüft ob er dem objekt schaden machen darf und zieht dann beiden objekt leben ab
  @override
  void damageOnCollision(List<Actor> actors) {
    for(Actor a in actors) {
      if (collision(a) && !shotId.contains(a.id) && a != this) {
        a.life -=  damage;
        life -= a.damage;
      }
    }
  }
}
