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
  List<String> classes = ['asteroid','enemy'];

  @override
  void accelerate() {
    speedY = -0.5;
    sizeX += growth;
    sizeY += growth;

    if (posY <= 0 || posX <= 0 || posX >= game.worldSizeX) {
      life = 0;
      collisionDetect = false;
    }
  }
}
