

import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/astroid.dart';
import 'package:dartmotion_master/model/boss.dart';
import 'package:dartmotion_master/model/cross.dart';
import 'package:dartmotion_master/model/elite.dart';
import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/player.dart';

class Game {

  int worldSizeX = 1000,
      worldSizeY = 1000;
  int fortschritt;
  String name;
  int currentEntityID = 0;
  Cross cross;
  Player player;
  List<Actor> actors = [];
  List<int> enemyShots =[];
  Game();


  ///updates each actor
  void update() {
    for (Actor a in actors) {
      if (a.isDead) {
        actors.remove(a);
      } else {
        a.update();
      }
    }
    actors.forEach((actor) => actor.damageOnCollision(actors));
  }
  ///maps an JSON file on a game + enemies
  Game.fromJson(Map<String, dynamic> json) {
    fortschritt = json['fortschritt'];
    name = json['name'];
    worldSizeX = json['worldSizeX'];
    worldSizeY = json['worldSizeY'];

    cross = Cross(this, currentEntityID++, 150, 50);
    player = Player(this, currentEntityID++, cross.posX, 20);
    player.cross = cross;
    actors.addAll([player, cross]);

    actors.addAll(_fillActorList(
        json['actorList'].cast<String>(),
        json['posXList'].cast<double>(),
        json['posYList'].cast<double>(),
        json['sizeXList'].cast<double>(),
        json['sizeYList'].cast<double>(),
        json['healthList'].cast<int>(),
        json['heavyList'].cast<bool>(),
        json['damageList'].cast<int>()));

  }
  ///wird mit den lsiten der JSON datei gefüllt
  ///erstellt gegner mit deren attributen
    List<Actor> _fillActorList(List<String> actorList,
        List<double> posXList,
        List<double> posYList,
        List<double> sizeXList,
        List<double> sizeYList,
        List<int> healthList,
        List<bool> heavyList,
        List<int> damageList) {
    List<Actor> actors = [];
      for (int i = 0; i < actorList.length; i++) {
        if (actorList[i] == 'casual') {
          actors.add(Enemy(
              this,
              currentEntityID++,
              posXList[i],
              posYList[i],
              sizeXList[i],
              sizeYList[i],
              healthList[i],
              heavyList[i],
              damageList[i]));
        } else if (actorList[i] == 'asteroid') {
          heavyList[i]
              ? actors.add(Asteroid.mega(
              this, currentEntityID++, posXList[i], posYList[i]))
              : actors.add(
              Asteroid(this, currentEntityID++, posXList[i], posYList[i]));
        } else if (actorList[i] == 'elite') {
          actors.add(Elite(
              this,
              currentEntityID++,
              posXList[i],
              posYList[i],
              sizeXList[i],
              sizeYList[i],
              healthList[i],
              heavyList[i],
              damageList[i]));
        } else if (actorList[i] == 'boss') {
          actors.add(Boss(
              this,
              currentEntityID++,
              posXList[i],
              posYList[i],
              sizeXList[i],
              sizeYList[i],
              healthList[i],
              heavyList[i],
              damageList[i]));
        }
      }
      return actors;
    }
  }
