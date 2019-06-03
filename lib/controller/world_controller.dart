import '../model/enemy.dart';
import '../model/vector.dart';
import '../model/world.dart';
import '../view/view.dart';
import 'dart:math';
import 'dart:html';
import '../model/casual.dart';
import '../model/asteroid.dart';
import '../model/boss.dart';

class WorldController {
  WorldController(World world, View view) {
    this.world = world;
    this.view = view;
    horizont = view.center_y.floor();
  }

  World world;
  View view;
  int horizont;

  List<Enemy> isInPlayerView() {
    List<Enemy> out = new List();
    for (Enemy e in this.world.enemies) {
      isEnemyInView(e) ? out.add(e) : false;
    }
    return out;
  }

  bool isEnemyInView(Enemy e) {
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X,
        this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
    if (temp.length() <= this.world.player.bufferCap)
      return true;
    else
      return false;
  }

  // Dies wollen wir am besten relativ gestalten
  double getOffsetToPlayerMiddle(Enemy e) {
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X,
        this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
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
  double getDistanceToPlayer(Enemy e) {
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X,
        this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
    Vector ninetyDegree = this.world.player.getVector();
    ninetyDegree.rotate(90);
    double rad = temp.getRadiusTo(ninetyDegree);
    double out = sin(rad) * temp.length();
    return out;
  }

  void displayEnemiesInView(List<Enemy> enemies) {
    for(int i = 0; i < enemies.length; i++){
      if(isEnemyInView(enemies[i])){
        if(enemies[i] is Casual){
          enemies[i].getImage().src = "Assets/casual.png";
        } else if(enemies[i] is Asteroid) {
          enemies[i].getImage().src = "Assets/asteroid.png";
        } else if(enemies[i] is Boss) {
          enemies[i].getImage().src = "Assets/boss.png";
        }
      } else {
        enemies[i].getImage().src = "";
      }
    }
  }

  Vector getXYFromPlayer(Enemy e) {
    Vector out = new Vector(0, 0);
    Vector temp = new Vector(0, 0);
    temp.betweenTwoPoints(this.world.player.curr_pos_X,
        this.world.player.curr_pos_Y, e.curr_pos_X, e.curr_pos_Y);
    Vector ninetyDegree = this.world.player.getVector();
    ninetyDegree.rotate(90);
    double rad = temp.getRadiusTo(ninetyDegree);
    out.dy = sin(rad) * temp.length(); //
    bool left;
    rad < 180 ? left = true : left = false;
    out.dx = cos(rad) * temp.length();
    left ? out.dx * -1 : out;
    return out;
  }

  List<Enemy> getEnemiesFromWorld() {
    return this.world.getEnemies();
  }

  void addEnemyToWorld(Enemy enemy) {
    world.enemies.add(enemy);
  }

  void simulate() {
    //Player first
    if (world.player.curr_pos_X + world.player.vector.dx >= world.boundaryX ||
        world.player.curr_pos_X + world.player.vector.dx <= 0) {
      world.player.vector.invertX();
    }
    if (world.player.curr_pos_Y + world.player.vector.dx >= world.boundaryY ||
        world.player.curr_pos_Y + world.player.vector.dx <= 0) {
      world.player.vector.invertY();
    }
    world.player.move();
    //now the world.enemies
    for (Enemy e in world.enemies) {
      if (e.curr_pos_X + e.vector.dx >= world.boundaryX ||
          e.curr_pos_X + e.vector.dx <= 0) {
        e.vector.invertX();
      }
      if (e.curr_pos_Y + e.vector.dy >= world.boundaryY ||
          e.curr_pos_Y + e.vector.dy <= 0) {
        e.vector.invertY();
      }
      e.move();
      //Hier müssen noch Anbindungen zum View rein?

    }

    /*
    List list = isInPlayerView();
    for(Enemy e in list){
      double y = -(getDistanceToPlayer(e)+2)*-(getDistanceToPlayer(e)+2)+this.horizont;
      view.updateEnemy(e, getOffsetToPlayerMiddle(e), y);
    }

  */
  }
}
