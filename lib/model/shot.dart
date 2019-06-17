import 'package:dartmotion_master/model/actor.dart';
import 'dart:math' as Math;

class Shot extends Actor {
  @override
  List<String> classes = ["shot"];

  ///Erstellt einen Schuss
  Shot(var game, int id, double posX, double posY, double posX2, double posY2)
      : super(game, id, posX, posY, 4, 16, 1) {
    ///berechnet den Einheitsvektor mit gegebenem Start und Zielkoordinate. Dadurch schießen Gegner in egal welcher Position gleich schnell
    double _betrag =
        Math.sqrt(Math.pow(posX2 - posX, 2) + Math.pow(posY2 - posY, 2));
    speedX = ((posX2 - posX) * (1 / _betrag)) *
        2; //multipliziert den Einheitsvektors mit 2 für doppelte Geschwindigkeit
    speedY = ((posY2 - posY) * (1 / _betrag)) * 2;
  }

  //muss überschrieben werden, da ein Schuss keine Beschleunigung erfährt
  @override
  void accelerate() {
    if (posY + speedY <= 0 ||
        posY + speedY >= game.worldSizeY ||
        posX + speedX <= 0 ||
        posX + speedX >= game.worldSizeX + game.cross.sizeY / 2) {
      life = 0;
      collisionDetect = false;
    }
    if(posY + speedY > game.screenSizeY - sizeY){
      life = 0;
    }
    speedX;
    speedY;
  }
}
