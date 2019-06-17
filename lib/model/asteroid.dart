import 'package:dartmotion_master/model/actor.dart';
import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/game.dart';

class Asteroid extends Actor {
  ///erstellt einen Asteroid
  Asteroid(Game game, int id, double posX, double posY, double sizeX,
      double sizeY, int life)
      : super(game, id, posX, posY, sizeX, sizeY, life);

  ///Überschreibt den Return von Classes
  @override
  List<String> classes = ['asteroid', 'enemy'];

  ///Überschreibt die Accelerate Funktion des Actors.
  ///Asteroiden wachsen mit der Zeit und werden schneller.
  @override
  void accelerate() {
    speedY = -0.4;
    sizeX += growth;
    sizeY += growth;
    speedX = posX + speedX <= 0 ? 0.1 : posX + speedX >= game.worldSizeX ? -0.1 : speedX;

    if (posY + speedY <= 0) {
      life = 0;
      collisionDetect = false;
    }
  }

  ///Erstellt 2 kleine Asteroiden, die sich weiter seitlich nach unten bewegen.
  ///Diese Funktion wird nur aufgerufen, wenn ein Asteroid vom Spieler zerstört wird.
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
