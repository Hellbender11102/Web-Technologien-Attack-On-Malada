import 'package:dartmotion_master/model/constants.dart';
import 'package:dartmotion_master/model/elite.dart';
import 'package:dartmotion_master/model/enemy.dart';
import 'package:dartmotion_master/model/shot.dart';

class Boss extends Elite {
  ///Erstellt einen Boss
  Boss(var game, int id, double posX, double posY, double sizeX, double sizeY,
      int life, int damage)
      : super(game, id, posX, posY, sizeX , sizeY, life, damage) {
    classes.add("boss");
  }

  ///Überschreibt die shootPlayer-Methode.
  ///Ein Boss schießt immer 3 Schüsse zusammen in verschiedene Richtungen
  @override
  void shootPlayer() {
    super.shootPlayer();
    var a = game.player;
    if (tickCount % (tick * 5) == 0) {
      Shot shot = Shot(game, game.currentEntityID++, posX + sizeX,
          posY + sizeY / 2, a.posX + a.sizeX * 3 / 2, a.posY)
        ..damage = this.damage
        ..classes.addAll(["enemyShot", "enemy"]);
      game.actors.add(shot);
      game.enemies.add(shot);
      shot = Shot(game, game.currentEntityID++, posX,
          posY + sizeY / 2, a.posX - a.sizeX * 3 / 2, a.posY)
        ..damage = this.damage
        ..classes.addAll(["enemyShot", "enemy"]);
      game.actors.add(shot);
      game.enemies.add(shot);
    }
  }

  @override
  void accelerate() {
    super.accelerate();
  }

  ///Überschreibt die Dodge-Methode vom Elite.
  ///Detection wurde für den Boss erhöht.
  @override
  void dodge(){
    double crossX = game.cross.posX;
    double crossY = game.cross.posY;
  
    if(crossX > posX && crossY > posY && (crossX - posX) <= 200 && (crossY - posY) <= 200){             // von oben rechts
      speedX--;
    } else if (posX > crossX && crossY > posY && (posX - crossX) <= 200 && (crossY - posY) <= 200) {    // von oben links
      speedX++;
    } else if(crossX > posX && posY > crossY && (crossX - posX) <= 200 && (posY - crossY) <= 200){      // von unten rechts
      speedX--;
      if (crossY < posY && (posY - crossY) <= 200){
        speedY++;
      }
    } else if (posX > crossX && posY > crossY && (posX - crossX) <= 200 && (posY - crossY) <= 200) {    // von unten links
      speedX++;
      if (crossY < posY && (posY - crossY) <= 200){
        speedY++;
      }
    }
  }
}
