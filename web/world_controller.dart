import 'enemy.dart';
import 'view.dart';
import 'world.dart';
import 'vector.dart';
import 'dart:math';

class WorldController{
  WorldController(World world, View view){
    this.world = world;
    this.view = view;
  }

  World world;
  View view;

  List<Enemy> isInPlayerView(){
    List<Enemy> out = new List();
    for(Enemy e in this.world.enemies){
      isEnemyInView(e) ? out.add(e) : false;
    }
    return out;
  }

  bool isEnemyInView(Enemy e){
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X, this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
    if(temp.length() <= this.world.player.bufferCap) return true;
    else return false;
  }

  // I dont know what the fuck just happened, but i dont really care, so imma get the fuck out of here
  // Dies wollen wir am besten relativ gestalten
  double getOffsetToPlayerMiddle(Enemy e){
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X, this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
    Vector ninetyDegree = this.world.player.getVector();
    ninetyDegree.rotate(90);
    double rad = temp.getRadiusTo(ninetyDegree);
    bool left;
    rad < 180 ? left = true : left = false;
    double out = cos(rad) * temp.length();
    left ? out * -1 : out;
    return out;
  }

  //Dies wollen wir am besten relativ gestalten
  double getDistanceToPlayer(Enemy e){
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X, this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
    Vector ninetyDegree = this.world.player.getVector();
    ninetyDegree.rotate(90);
    double rad = temp.getRadiusTo(ninetyDegree);
    double out = sin(rad) * temp.length();
    return out;
  }

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
      //Hier müssen noch Anbindungen zum View rein?
    }
  }
}