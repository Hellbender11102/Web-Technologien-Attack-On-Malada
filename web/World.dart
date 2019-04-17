import 'Player.dart';
import 'Enemy.dart';

class World {
  Player player;
  List<Enemy> enemies;
  //Image background;
  double boundaryX;
  double boundaryY;

  World(boundaryX, boundaryY, player, enemies);

  bool simulate(){
    //Player first
    if(player.curr_pos_X + player.vector.dx >= boundaryX || player.curr_pos_X + player.vector.dx <= 0){
      player.vector.invertX();
    }
    if(player.curr_pos_Y + player.vector.dx >= boundaryY || player.curr_pos_Y + player.vector.dx <= 0){
      player.vector.invertY();
    }
    player.move();
    //now the enemies
    for(Enemy e in enemies){
      if(e.curr_pos_X + e.vector.dx >= boundaryX || e.curr_pos_X + e.vector.dx <= 0){
        e.vector.invertX();
      }
      if(e.curr_pos_Y + e.vector.dy >= boundaryY || e.curr_pos_Y + e.vector.dy <= 0){
        e.vector.invertY();
      }
      e.move();
    }
  }
}