import 'dart:math';

import 'package:dartmotion_master/model/game.dart';
import 'package:dartmotion_master/model/healthUp.dart';

abstract class Actor {
  /// constants
  final maxSpeed = 5;
  final accelerationMod = 0.0075;

  ///zählt bei jedem update den tick mit
  ///wird bei den Objekten enemy und player gebraucht
  int tickCount = 0;

  //muss 1 > x >= 0  sein
  /// brake ist dafür da, dass der Spieler sich nach tastendruck leicht weiterbewegt
  /// und momentum verliert
  /// Wird mit dem Aktuellen Speed multipliziert
  final brake = 0.75;

  ///für das design
  List<String> classes = ["actor"];
  int id;
  Game game;
  int damage = 1;

  ///var game ist das Aktuelle spiel
  ///int id ist eine einzigartiger id um diesen im dom zu verwalten
  ///double posX ist die aktuelle position auf der X kooridnate
  ///double posY ist die aktuelle position auf der Y kooridnate
  Actor(this.game, this.id, this.posX, this.posY, this.sizeX, this.sizeY,
      this.life);

  ///position
  double posX;
  double posY;

  ///hitbox
  double sizeX;
  double sizeY;

  ///wird benutzt um objekte vor kollisionen zu schützen
  bool collisionDetect = true;

  ///bewegungsgeschwindigkeit ind X oder Y richtung
  double speedX = 0.0;
  double speedY = 0.0;

  ///ändert die bewegungsgeschwindigkeit um den accelerationwert
  double accelerationX = 0.0;
  double accelerationY = 0.0;

  ///leben des Actors
  int life;

  ///wenn der Actor kein Leben mehr hat wir false zurückgegeben
  /// x > 0 return true
  bool get isDead => life <= 0;

  ///nächste position += speed
  void accelerate() {
    speedX = _getSpeed(speedX, accelerationX);
    speedY = _getSpeed(speedY, accelerationY);
  }

  ///nächste position += speed
  void move() {
    posX = keepInBounds(speedX, posX, game.worldSizeX.toDouble());
    posY = keepInBounds(speedY, posY, game.worldSizeY.toDouble());
  }

  ///überprüft ob die beschläunigung über den maximalwert 15 steigt
  ///wenn ja wird es auf 15 zurück gestzt
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

  ///der Actor berechnet die beschleunigung
  ///führt die move mit der neuen beschleunigung aus
  update() {
    accelerate();
    move();
  }

  ///überprüft ob 2 objekte überschneiden
  ///und beide Objekte leben
  ///und ob beide Objekte collisionDetect = true sind
  ///Actor actor ist das zu vergleichende Objekt
  bool collision(Actor actor) {
    return collisionDetect && actor.collisionDetect && !isDead && !actor.isDead
        ? (actor.posX < posX + sizeX &&
            actor.posX + actor.sizeX > posX &&
            actor.posY < posY + sizeY &&
            actor.posY + actor.sizeY > posY)
        : false;
  }

  ///lässt den nächsten move nicht aus den worldbounds
  ///double speed geschwindigkeit des actors
  ///double pos ist Die derzeitige position X und Y
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

  /// überproft ob das objekt schaden bekommen kann und sollte von der eigenen klasse
  void damageOnCollision(List<Actor> actors) {
    for (Actor a in actors) {
      //if für aufteilung von gegner collisionen mit anderen gegnern
      if (collision(a) &&
          (!game.enemies.contains(a) || !game.enemies.contains(this))) {
        // if für eigene schüsse die dem player kein schaden machen dürfen
        if (!game.player.firendlyId.contains(id) && !a.classes.contains("player")) {
          a.life -= damage;
          life -= a.damage;
        }
      }
    }
  }
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
