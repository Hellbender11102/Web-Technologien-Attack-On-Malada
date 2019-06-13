
import 'package:dartmotion_master/model/actor.dart';

class Cross extends Actor {
  Cross(var game,int id, double posX, double posY)
      : super(game,id, posX, posY, 62,62,0) {
    classes.add("cross");
    collisionDetect = false;
  }

  @override
  bool get isDead => false;

}
