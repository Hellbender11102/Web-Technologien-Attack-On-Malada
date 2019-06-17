import 'dart:math';

import 'package:dartmotion_master/model/game.dart';
import 'package:dartmotion_master/model/healthUp.dart';

abstract class Actor {
  ///Konstanten
  final maxSpeed = 5;
  final accelerationMod = 0.0075;

  ///Zählt bei jedem Update den Tick mit.
  ///wird bei den Objekten Enemy und Player gebraucht.
  int tickCount = 0;

  //muss 1 > x >= 0  sein
  /// brake ist dafür da, dass der Spieler sich nach Tastendruck leicht weiterbewegt und Momentum verliert.
  /// Wird mit dem aktuellen Speed multipliziert.
  final brake = 0.80;

  ///Für das Design
  List<String> classes = ["actor"];
  int id;
  Game game;
  int damage = 1;

  ///var game ist das aktuelle spiel
  ///int id ist eine einzigartige Id, um den Actor im Dom zu verwalten.
  ///double posX ist die aktuelle Position auf der X-Koordinate.
  ///double posY ist die aktuelle Position auf der Y-Koordinate.
  Actor(this.game, this.id, this.posX, this.posY, this.sizeX, this.sizeY,
      this.life);

  ///X-Position
  double posX;
  ///Y-Position
  double posY;

  ///Breite
  double sizeX;
  ///Höhe
  double sizeY;

  ///wird benutzt, um Objekte vor Kollisionen zu schützen
  bool collisionDetect = true;

  ///Bewegungsgeschwindigkeit in X-Richtung
  double speedX = 0.0;
  ///Bewegungsgeschwindigkeit in Y-Richtung
  double speedY = 0.0;

  ///Ändert die Bewegungsgeschwindigkeit in X-Richtung um den Acceleration-Wert
  double accelerationX = 0.0;
  ///Ändert die Bewegungsgeschwindigkeit in Y-Richtung um den Acceleration-Wert
  double accelerationY = 0.0;

  ///Leben des Actors
  int life;

  ///Wenn der Actor kein Leben mehr hat, wird false zurückgegeben.
  ///x > 0 return true
  bool get isDead => life <= 0;

  ///Beschleunigt, um den Acceleration-Wert, um die neue Geschwindigkeit zu bekommen
  void accelerate() {
    speedX = _getSpeed(speedX, accelerationX);
    speedY = _getSpeed(speedY, accelerationY);
  }

  ///Nächste Position += speed mit Check, ob man innerhalb des sichtbaren Spielfeldes bleibt
  void move() {
    posX = keepInBounds(speedX, posX, game.worldSizeX.toDouble());
    posY = keepInBounds(speedY, posY, game.worldSizeY.toDouble());
  }

  ///Überprüft, ob die Beschleunigung über den Maximalwert 15 steigt
  ///Wenn ja, wird es auf 15 zurückgesetzt
  double _getSpeed(double speed, double acceleration) {
    speed += acceleration * accelerationMod;
    if (speed.abs() > maxSpeed) {
      speed = speed > 0 ? maxSpeed.toDouble() : (-maxSpeed).toDouble();
    }
    // auto brake if no acceleration
    if (acceleration == 0) {
      return speed * brake;
    }
    return speed;
  }

  ///Der Actor berechnet die Beschleunigung
  ///Führt die move mit der neuen Beschleunigung aus
  void update() {
    accelerate();
    move();
  }

  ///Überprüft, ob 2 Objekte sich überschneiden, beide Objekte leben und ob beide Objekte collisionDetect = true sind
  ///Actor actor ist das zu vergleichende Objekt
  bool collision(Actor actor) {
    return collisionDetect && actor.collisionDetect && !isDead && !actor.isDead
        ? (actor.posX < posX + sizeX &&
            actor.posX + actor.sizeX > posX &&
            actor.posY < posY + sizeY &&
            actor.posY + actor.sizeY > posY)
        : false;
  }

  String toString() => "ID:$id Position x:$posX  Position y:$posY";

  ///Lässt den nächsten Move nicht aus dem sichtbaren Spielfeld raus
  ///double speed Geschwindigkeit des Actors
  ///double pos ist die derzeitige X- oder Y-Position
  ///double max ist unsere Spielfeldgrenze für jeweils X oder Y
  double keepInBounds(double speed, double pos, double max) {
    if (pos + speed > max) {
      pos = max - 25;
    } else if (pos + speed <= 0) {
      pos = 0;
    } else {
      pos += speed;
    }
    return pos;
  }

  void shootPlayer() {}

  ///Überprüft, ob das Objekt Schaden bekommen kann
  void damageOnCollision(List<Actor> actors) {
    for (Actor a in actors) {
      //if für Aufteilung von Gegner-Kollisionen mit anderen Gegnern
      if (collision(a) &&
          (!game.enemies.contains(a) || !game.enemies.contains(this))) {
        //if für eigene Schüsse, die dem Player keinen Schaden machen dürfen
     if (!game.player.firendlyId.contains(id) && !a.classes.contains("player")) {
          a.life -= damage;
          life -= a.damage;
        }
      }
    }
  }

  ///Fügt einem Gegner mit einer Chance von 10% ein PowerUp hinzu in Form eines Health-Ups
  void dropHealthUp(){
    double random =Random().nextDouble();
    if(random >= 0.9){
      HealthUp healthUp = HealthUp(game,game.currentEntityID++,posX-sizeX/2,posY-sizeY/2);
      game.actors.add(healthUp);
      game.enemies.add(healthUp);
      game.player.firendlyId.add(healthUp.id);
    }
  }
}
