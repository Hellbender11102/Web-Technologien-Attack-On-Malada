import 'dart:html';
import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/asteroid.dart';
import 'package:dartmotion_master/model/boss.dart';
import 'package:dartmotion_master/model/cross.dart';
import 'package:dartmotion_master/model/elite.dart';
import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/player.dart';

class Game {
  ///int worldSizeX ist die Breite des Levels
  ///int worldSizeY ist die Höhe des Levels
  ///int screenSizeY ist die Höhe des sichtbaren Spielfeldes
  int worldSizeX, worldSizeY, screenSizeY = window.innerHeight;
  ///int fortschritt gibt an, in welchem Level man sich befindet
  int fortschritt;
  ///String name ist der Name des Levels
  String name;
  int currentEntityID = 0;
  Cross cross;
  Player player;
  List<Actor> actors = [];
  List<Actor> enemies = [];

  Game();

  ///Updatet jeden Actor
  void update() {
    for (Actor a in actors) {
      if (a.isDead) {
        if(a.classes.contains('asteroid')&& a.sizeY +a.sizeY > 120) {
          Asteroid asteroid = a;
          asteroid.split();
        }else if(!a.classes.contains('shot') && !a.classes.contains('asteroid') && !a.classes.contains('healthUp')) {
          a.dropHealthUp();
        }
        actors.remove(a);
        enemies.remove(a);
      } else {
        a.update();
      }
    }
    actors.forEach((actor) => actor.damageOnCollision(actors));
  }

  ///Führt für alle Gegner den Schuss aus
  void shoot() {
    for (Actor a in actors) {
      if (!a.isDead) {
        a.shootPlayer();
      }
    }
  }

  ///Mappt die JSON-Datei zu einem Level.
  ///Map<String, dynamic> json ist die JSON-Datei
  ///int worldSizeX ist die Breite des Levels
  Game.fromJson(Map<String, dynamic> json, this.worldSizeX) {
    fortschritt = json['fortschritt'];
    name = json['name'];
    worldSizeY = json['worldSizeY'];

    cross = Cross(this, currentEntityID++, 300, 100);
    player = Player(this, currentEntityID++, cross.posX, 20);
    player.cross = cross;
    _fillActorList(
        json['actorList'].cast<String>(),
        json['posXList'].cast<double>(),
        json['posYList'].cast<double>(),
        json['sizeXList'].cast<double>(),
        json['sizeYList'].cast<double>(),
        json['healthList'].cast<int>(),
        json['heavyList'].cast<bool>(),
        json['damageList'].cast<int>());
    actors.addAll([player, cross]);
  }

  ///Wird mit den Listen der JSON-Datei gefüllt.
  ///Erstellt Gegner mit deren Attributen, prüft dabei noch, ob die Gegner das Heavy-Attribut true ist und rechnet dementsprechend
  ///Leben und Damage um.
  void _fillActorList(
      List<String> actorList,
      List<double> posXList,
      List<double> posYList,
      List<double> sizeXList,
      List<double> sizeYList,
      List<int> healthList,
      List<bool> heavyList,
      List<int> damageList) {
    for (int i = 0; i < actorList.length; i++) {
      if (actorList[i] == 'casual') {
        actors.add(heavyList[i]
            ? (Enemy(
                this,
                currentEntityID++,
                _calcXPos(posXList[i]),
                posYList[i],
                sizeXList[i],
                sizeYList[i],
                healthList[i] * 2,
                damageList[i] * 2))
            : Enemy(this, currentEntityID++, _calcXPos(posXList[i]), posYList[i],
                sizeXList[i], sizeYList[i], healthList[i], damageList[i]));
      } else if (actorList[i] == 'asteroid') {
        actors.add(heavyList[i]
            ? Asteroid(this, currentEntityID++, _calcXPos(posXList[i]), posYList[i],
                sizeXList[i], sizeYList[i], healthList[i] * 2)
            : Asteroid(this, currentEntityID++, _calcXPos(posXList[i]), posYList[i],
                sizeXList[i], sizeYList[i], healthList[i]));
      } else if (actorList[i] == 'elite') {
        actors.add(heavyList[i]
            ? Elite(
                this,
                currentEntityID++,
                _calcXPos(posXList[i]),
                posYList[i],
                sizeXList[i],
                sizeYList[i],
                healthList[i] * 2,
                damageList[i] * 2)
            : Elite(this, currentEntityID++, _calcXPos(posXList[i]), posYList[i],
                sizeXList[i], sizeYList[i], healthList[i], damageList[i]));
      } else if (actorList[i] == 'boss') {
        actors.add(Boss(this, currentEntityID++, _calcXPos(posXList[i]), posYList[i],
            sizeXList[i], sizeYList[i], healthList[i], damageList[i]));
      }
    }
    enemies.addAll(actors);
  }

  ///Verrechnet die X-Position des Actors mit der Breite des Bildschirms.
  ///return Gibt die auf den Bildschirm angepasste X-Position zurück
  double _calcXPos (double posX){
    return posX * worldSizeX;
  }
}
