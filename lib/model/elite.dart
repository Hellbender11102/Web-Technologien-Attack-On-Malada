import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/player.dart';

class Elite extends Enemy {
  List<String> classes = ["elite", 'enemy'];

  Elite(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, int damage)
      : super(game, id, posX, posY, sizeX, sizeY, life, damage);

  ///Elite gegner bekommen ein besonderes movment welches sich auf das Fadenkreuz bezieht
  @override
  void move() {
    super.move();
    double crossX = game.cross.posX;
    double crossY = game.cross.posY;
    double crossSizeX = game.cross.sizeX;
    double crossSizeY = game.cross.sizeY;
    if (crossX > posX && posX < crossX + crossSizeX) {
      speedX +=  posX -crossX > 0 ? 2: -2;
    }
    if (crossY > posY && posY < crossY + crossSizeY) {
      speedY +=  posY -crossY > 0 ? 2: -2;
    }
  }
}
