import 'dart:html';
import 'enemy.dart';
import 'player.dart';
import 'world.dart';

class MiniMap {
  double worldSizeX;
  double worldSizeY;
  var MinimapElement = querySelector(".minimap");
  var Screen = querySelector("#screen");

  ImageElement playerDot = new ImageElement();
  List<ImageElement> enemyDots = new List<ImageElement>();

  MiniMap(World world) {

    this.worldSizeX = world.boundaryX;
    this.worldSizeY = world.boundaryY;
    this.playerDot.src = "Assets/MiniMap_Circle_Player.png";
    this.playerDot.className = "playerOnMap";
    MinimapElement.children.add(playerDot);

//We add the background for the minimap with this little piece of code
    UListElement griddy = new UListElement();
    for (int i = 0; i < 9; i++) {
      LIElement box = new LIElement();
      griddy.children.add(box);
    }
    MinimapElement.children.add(griddy);

//Alle Gegner hinzufügen
    for (int i = 0; i < world.enemies.length; i++) {
      ImageElement enemy = new ImageElement();
      enemy.src = "Assets/EnemyBeepBeep.png";
      enemy.className = "enemy";
      enemy.id = "enemyDotNr$i";
      enemyDots.add(enemy);
      MinimapElement.children.add(enemy);
    }
  }

  void adjust(Player thatMe, List<Enemy> enemies) {
//Einmal für den Spieler
    playerDot.style.left = '${((thatMe.curr_pos_X / worldSizeX) * 100)}%';
    playerDot.style.bottom = '${((thatMe.curr_pos_Y / worldSizeY) * 100)}%';

//Einmal für alle Gegner
    int i = 0;
//Hierfür erstellen wir uns ein vorübergehendes ImageElement, welches dann geänderte Werte bekommt
    ImageElement temporaryImageHolder;
    for (Enemy e in enemies) {
      if(enemyDots[i].id != "enemyDotNr$i"){
        enemyDots[i].id = "enemyDotNr$i";
      }
      temporaryImageHolder = enemyDots.firstWhere((x) =>
          x.id ==
          "enemyDotNr$i"); //Anhand von i bekommen wir hier das dazugehörige Element
      i++;
      temporaryImageHolder.style.left =
          '${((e.curr_pos_X / worldSizeX) * 100)}%';
      temporaryImageHolder.style.bottom =
          '${((e.curr_pos_Y / worldSizeY) * 100)}%';
    }
  }

  void deletDot(int deadDot) {
    enemyDots[deadDot].remove();
    enemyDots.removeAt(deadDot);
  }
}
