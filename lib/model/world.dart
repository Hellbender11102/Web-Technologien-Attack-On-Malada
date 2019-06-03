import 'level.dart';
import 'player.dart';
import 'enemy.dart';

class World {
  Player player;
  List<Enemy> enemies;
  //Image background;
  double boundaryX;
  double boundaryY;
  Level level;
  World(this.boundaryX,this.boundaryY,this.player,this.enemies);


String toString(){
  return "World: X: $boundaryX Y: $boundaryY EnemyList:  ${enemies.toString()}\nPlayer:${player.toString()}";
}
void setLevel(Level level){
  this.level= level;
}
List<Enemy> getEnemies(){
  return this.enemies.toList();
}
  
}