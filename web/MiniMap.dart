import 'dart:html';
import 'Enemy.dart';
import 'Player.dart';
import 'World.dart';

class MiniMap{
  double worldSizeX;
  double worldSizeY;
  var MinimapElement = querySelector(".minimap");

  ImageElement playerDot = new ImageElement();
  List<ImageElement> enemyDots = new List<ImageElement>();

  MiniMap(World world){
    this.worldSizeX = world.boundaryX;
    this.worldSizeY = world.boundaryY;
    this.playerDot.src = "Assets/MiniMap_Circle_Player.png";
    this.playerDot.className = "playerOnMap";
    MinimapElement.children.add(playerDot);

    //Alle Gegner hinzufügen
    for(int i = 0; i < world.enemies.length; i++){
      ImageElement enemy = new ImageElement();
      enemy.src = "Assets/EnemyBeepBeep.png";
      enemy.className = "enemy";
      enemy.id = "enemyDotNr$i";
      i++;
      enemyDots.add(enemy);
      MinimapElement.children.add(enemy);
    }
  }

  void adjust(Player thatMe, List<Enemy> enemies){
    //Einmal für den Spieler
    playerDot.style.left = '${((thatMe.curr_pos_X / worldSizeX) * 100)}px';
    playerDot.style.bottom = '${((thatMe.curr_pos_Y / worldSizeY) * 100)}px';

    //Einmal für alle Gegner
    int i = 0;
    //Hierfür erstellen wir uns ein vorübergehendes ImageElement, welches dann geänderte Werte bekommt
    ImageElement temporaryImageHolder;
    for(Enemy e in enemies){
      temporaryImageHolder = querySelector("#enemyDotNr$i"); //Anhand von i bekommen wir hier das dazugehörige Element
      i++;
      temporaryImageHolder.style.left = '${((e.curr_pos_X / worldSizeX) * 100)}px';
      temporaryImageHolder.style.bottom = '${((e.curr_pos_Y / worldSizeY) * 100)}px';
    }
  }
}