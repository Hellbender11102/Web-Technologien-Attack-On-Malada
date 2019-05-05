import 'Player.dart';
import 'Enemy.dart';

class World {
  Player player;
  List<Enemy> enemies;
  //Image background;
  double boundaryX;
  double boundaryY;

  World(boundaryX, boundaryY, player, enemies);

  void simulate(){
    //Player first
    if(this.player.curr_pos_X + this.player.vector.dx >= boundaryX || this.player.curr_pos_X + this.player.vector.dx <= 0){
      this.player.vector.invertX();
    }
    if(this.player.curr_pos_Y + this.player.vector.dx >= boundaryY || this.player.curr_pos_Y + this.player.vector.dx <= 0){
      this.player.vector.invertY();
    }
    this.player.move();
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