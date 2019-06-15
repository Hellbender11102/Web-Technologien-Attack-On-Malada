import 'package:dartmotion_master/model/game.dart';
import 'package:dartmotion_master/model/player.dart';

abstract class Actor {
  /// constants
  final maxSpeed = 5;
  final accelerationMod = 0.005;
  final brake = 0.95;

  ///für das design
  List<String> classes = ["actor"];
  int id;
  Game game;
  int damage = 1;

  Actor(this.game, this.id, this.posX, this.posY, this.sizeX, this.sizeY,
      this.life);

  ///position
  double posX;
  double posY;

  ///hitbox
  double sizeX;
  double sizeY;
  bool collisionDetect = true;

  double speedX = 0.0;
  double speedY = 0.0;

  double accelerationX = 0.0;
  double accelerationY = 0.0;

  int life;

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

  update() {
    accelerate();
    move();
  }

  ///überprüft ob 2 objekte überschneiden
  bool collision(Actor actor) {
    return collisionDetect && actor.collisionDetect
        ? (actor.posX < posX + sizeX &&
            actor.posX + actor.sizeX > posX &&
            actor.posY < posY + sizeY &&
            actor.posY + actor.sizeY > posY)
        : false;
  }

  String toString() => "ID:$id Position x:$posX  Position y:$posY";

  ///lässt den nächsten move nicht aus den worldbounds
  double keepInBounds(double speed, double pos, double max) {
    if (pos + speed > max) {
      pos = max;
    } else if (pos + speed < 0) {
      pos = 0;
    } else {
      pos += speed;
    }
    return pos;
  }

  void shootPlayer() {}

  void damageOnCollision(List<Actor> actors) {
    for (Actor a in actors) {
      if (collision(a) &&
          !a.isDead &&
          !isDead &&
          !game.enemyShots.contains(a.id) &&
          a != this &&
          collisionDetect) {
        if (game.player.shotId.contains(id) && a.classes.contains("player")) {
          print(a.classes.toString() + classes.toString());
        } else {
          a.life -= damage;
          life -= a.damage;
        }
      }
    }
  }
}
