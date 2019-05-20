import 'player.dart';
import 'enemy.dart';

class World {
  Player player;
  List<Enemy> enemies;
  //Image background;
  double boundaryX;
  double boundaryY;

  World(double boundaryX,double boundaryY,Player player,List<Enemy> enemies){
    this.boundaryX = boundaryX;
    this.boundaryY = boundaryY;
    this.player = player;
    this.enemies = enemies;
  }


String toString(){
  return "World: X: $boundaryX Y: $boundaryY EnemyList:  ${enemies.toString()}\nPlayer:${player.toString()}";
}
  
}