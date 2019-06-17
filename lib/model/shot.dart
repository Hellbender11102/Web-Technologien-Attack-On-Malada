import 'package:dartmotion_master/model/actor.dart';
import 'dart:math' as Math;

class Shot extends Actor {
  @override
  List<String> classes = ["shot"];

  Shot(var game, int id, double posX, double posY, double posX2, double posY2)
      : super(game, id, posX, posY, 8, 16, 1) {
    ///berechnet den einheitsvektor mit gegebenen start und zielkoordinate. dadurch schießen gegner in egal welcher position gleich schnell
    double _betrag =
        Math.sqrt(Math.pow(posX2 - posX, 2) + Math.pow(posY2 - posY, 2));
    speedX = (posX2 - posX) * (1 / _betrag);
    speedY = (posY2 - posY) * (1 / _betrag);
  }

  //muss überschrieben werden da ein schuss keine beschleunigung erfährt
  @override
  void accelerate() {
    if (posY + speedY <= 0 ||
        posY + speedY >= game.worldSizeY ||
        posX + speedX <= 0 ||
        posX + speedX >= game.worldSizeX + game.cross.sizeY / 2) {
      life = 0;
      collisionDetect = false;
    }
    speedX;
    speedY;
  }
}
