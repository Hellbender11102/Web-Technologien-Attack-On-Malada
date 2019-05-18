<<<<<<< HEAD:web/WorldController.dart
import 'Enemy.dart';
import 'World.dart';
=======
import 'dart:html';
import 'enemy.dart';
import 'world.dart';
>>>>>>> 82c09bcfe78c7a494b010f19e9c0f2039fdb30d8:web/world_controller.dart

class WorldController{
  WorldController(World world){
    this.world = world;
  }

  World world;
  
  /* 
  List<ImageElement> getAllEnemysFromView(){
    return querySelectorAll(".enemy");
  }
  */

  List<Enemy> getEnemiesFromWorld(){
    return this.world.enemies;
  }

  void addEnemyToWorld(Enemy enemy){
    world.enemies.add(enemy);
  }
  
  void simulate(){
    //Player first
    if(world.player.curr_pos_X + world.player.vector.dx >= world.boundaryX || world.player.curr_pos_X + world.player.vector.dx <= 0){
      world.player.vector.invertX();
    }
    if(world.player.curr_pos_Y + world.player.vector.dx >= world.boundaryY || world.player.curr_pos_Y + world.player.vector.dx <= 0){
      world.player.vector.invertY();
    }
    world.player.move();
    //now the world.enemies
    for(Enemy e in world.enemies){
      if(e.curr_pos_X + e.vector.dx >= world.boundaryX || e.curr_pos_X + e.vector.dx <= 0){
        e.vector.invertX();
      }
      if(e.curr_pos_Y + e.vector.dy >= world.boundaryY || e.curr_pos_Y + e.vector.dy <= 0){
        e.vector.invertY();
      }
      e.move();
    }
  }
}