import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/game.dart';

class Asteroid extends Actor {
  ///erstellt ein astroid
  Asteroid(Game game, int id, double posX, double posY, double sizeX,
      double sizeY, int life)
      : super(game, id, posX, posY, sizeX, sizeY, life);

  ///überschreibt den return von classes
  @override
  List<String> classes = ['asteroid', 'enemy'];

  @override
  void accelerate() {
    speedY = -0.4;
    sizeX += growth;
    sizeY += growth;

    if (posY <= 0 || posX <= 0 || posX >= game.worldSizeX) {
      life = 0;
      collisionDetect = false;
    }
  }
 ///erstellt 2 kleine Asteroiden die sich weiter seitlich nach unten bewegen
  void split() {
    Asteroid a1 =
        Asteroid(game, game.currentEntityID++, this.posX+ this.sizeX/2, this.posY, 20, 20, 1)
          ..speedX = -0.1
          ..speedY = 0.2;
    Asteroid a2 =
        Asteroid(game, game.currentEntityID++, this.posX + this.sizeX/2, this.posY, 20, 20, 1)
          ..speedX = 0.1
          ..speedY = 0.2;
    game.actors.addAll([a1, a2]);
    game.enemies.addAll([a1, a2]);
  }
}
