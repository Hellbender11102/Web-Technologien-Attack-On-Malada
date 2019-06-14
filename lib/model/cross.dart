
import 'package:dartmotion_master/model/actor.dart';

class Cross extends Actor {

  @override
  List<String> classes = ["cross"];
  Cross(var game,int id, double posX, double posY)
      : super(game,id, posX, posY, 62,62,0) {
    collisionDetect = false;
  }

  @override
  bool get isDead => false;

}
