
import 'package:dartmotion_master/model/actor.dart';

class Cross extends Actor {

  @override
  List<String> classes = ["cross"];
  Cross(var game,int id, double posX, double posY)
      : super(game,id, posX, posY, 62,62,0);

  @override
  bool get isDead => false;

  @override
  bool collisionDetect = false;

  @override
  void move() {
    posX = keepInBounds(speedX, posX, game.worldSizeX.toDouble() - sizeX/2);
    posY = keepInBounds(speedY, posY, game.screenSizeY.toDouble() - sizeY);
  }
}
