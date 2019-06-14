
import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/game.dart';

class Asteroid extends Actor {
  ///erstellt ein astroid
  Asteroid(Game game, int id, double posX, double posY)
      : super(game, id, posX, posY, 32, 32, 1);
  ///erstellt ein grßen asteroid
  Asteroid.mega(Game game, int id, double posX, double posY)
      : super(game, id, posX, posY, 64, 64, 4);

  ///überschreibt den return von classes
  @override
  List<String> classes = ['asteroid'];


  @override
  void accelerate() {
    speedY = -0.5;
    sizeX += growth;
    sizeY += growth;

    if (posY <=  0 || posY >= game.worldSizeY || posX <=  0 || posX >= game.worldSizeX){
      life = 0;
      collisionDetect = false;
    }
  }
}
