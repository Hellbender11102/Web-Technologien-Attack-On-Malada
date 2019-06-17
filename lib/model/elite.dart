import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/player.dart';

class Elite extends Enemy {
  List<String> classes = ["elite", 'enemy'];

  ///Erstellt einen Elite
  Elite(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, int damage)
      : super(game, id, posX, posY, sizeX, sizeY, life, damage);

  ///Elite Gegner bekommen ein besonderes Movement, welches sich auf das Fadenkreuz bezieht.
  ///Im Vergleich zum normalen Enemy kommt hier die Dodge-Methode hinzu.
  @override
  void accelerate() {
    dodge();
    super.accelerate();
  }

  ///Die Dodge-Methode ändert die Richtung durch den Parameter SpeedX/SpeedY, falls das Fadenkreuz dem Elite zu nahe kommt.
  ///Die Bewegungsrichtung wird entsprechend der Richtung, aus dem das Fadenkreuz kommt, geändert.
  void dodge(){
    double crossX = game.cross.posX;
    double crossY = game.cross.posY;
  
    if(crossX > posX && crossY > posY && (crossX - posX) <= 100 && (crossY - posY) <= 100){             // von oben rechts
      speedX--;
    } else if (posX > crossX && crossY > posY && (posX - crossX) <= 100 && (crossY - posY) <= 100) {    // von oben links
      speedX++;
    } else if(crossX > posX && posY > crossY && (crossX - posX) <= 100 && (posY - crossY) <= 100){      // von unten rechts
      speedX--;
      if (crossY < posY && (posY - crossY) <= 100){
        speedY++;
      }
    } else if (posX > crossX && posY > crossY && (posX - crossX) <= 100 && (posY - crossY) <= 100) {    // von unten links
      speedX++;
      if (crossY < posY && (posY - crossY) <= 100){
        speedY++;
      }
    }
  }
}
