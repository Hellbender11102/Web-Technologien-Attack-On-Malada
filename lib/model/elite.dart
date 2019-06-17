import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/player.dart';

class Elite extends Enemy {
  List<String> classes = ["elite", 'enemy'];

  Elite(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, int damage)
      : super(game, id, posX, posY, sizeX, sizeY, life, damage);

  ///Elite gegner bekommen ein besonderes movment welches sich auf das Fadenkreuz bezieht
  @override
  void accelerate() {
    dodge();
    if (posY < game.worldSizeY && posY >= game.screenSizeY - sizeY) {
      speedY = -0.25;
    } else if (posY < 0 + sizeY * 2) {
      speedY = 0.25;
    } else {
      speedY = speedY >= 0 ? 0.25 : -0.25;
    }
    if (posX > game.worldSizeX - sizeX) {
      speedX = -0.5;
    } else if (posX < 0 + sizeX) {
      speedX = 0.5;
    } else {
      speedX = speedX >= 0 ? 0.5 : -0.5;
    }
  }

  void dodge(){
    double crossX = game.cross.posX;
    double crossY = game.cross.posY;
  
    if(crossX > posX && crossY > posY && (crossX - posX) <= 100 && (crossY - posY) <= 100){             // von oben rechts
      speedX--;
    } else if (posX > crossX && crossY > posY && (posX - crossX) <= 100 && (crossY - posY) <= 100) {    // von oben links
      speedX++;
    } else if(crossX > posX && posY > crossY && (crossX - posX) <= 100 && (posY - crossY) <= 100){      // von unten rechts
      speedX--;
    } else if (posX > crossX && posY > crossY && (posX - crossX) <= 100 && (posY - crossY) <= 100) {    // von unten links
      speedX++;
    }
  }
}
