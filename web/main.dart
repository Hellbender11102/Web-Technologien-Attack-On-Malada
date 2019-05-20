import 'dart:async';
import 'dart:html';
import 'dart:convert' as JSON;
import 'dart:math';
import 'model/casuals.dart';
import 'model/enemy.dart';
import 'model/level.dart';
import 'model/mini_map.dart';
import 'model/world.dart';
import 'model/player.dart';
import 'controller/world_controller.dart';
import 'model/asteroid.dart';

import 'view/view.dart';

void main() {
  String lvl1 = '{"fortschritt": 0,"name": "Aller","spawnTime": 2,"numberOnScreen":5,"type":["asteroid","casual"],"numberTilFinish":20}';
  String lvl2 = '{"fortschritt": 1,"name": "Anfang","spawnTime": 1,"numberOnScreen":10,"type":["asteroid","casual"],"numberTilFinish":40}';
  String lvl3 = '{"fortschritt": 1,"name": "ist","spawnWidth": 100,"spawnTime": 3,"number":20,"enemies":[{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1}]}';
  String lvl4 = '{"fortschritt": 1,"name": "schwer","spawnWidth": 100,"spawnTime": 2,"number":40,"enemies":[{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1}]}';
  Map<String,dynamic> lvlMap;
  Level lvl;
  View view = new View();
  bool isStarted = false;
  view.startBtn.onTouchEnd.listen((e) {
    if (!isStarted) {
      lvlMap = lvlMap== null ? JSON.jsonDecode(lvl1):JSON.jsonDecode(lvl2);
      lvl = Level.fromJson(lvlMap);
      start(view,lvl,isStarted);
      view.screen.children.remove(view.startBtn);
      isStarted = true;
    }
  });
  window.onClick.listen((e) {
    if (!isStarted) {
      lvlMap =lvlMap == null ? JSON.jsonDecode(lvl1) : JSON.jsonDecode(lvl2);
      lvl = Level.fromJson(lvlMap);
      start(view,lvl,isStarted);
      view.screen.children.remove(view.startBtn);
      isStarted = true;
    }
  });
}

void start(View view,Level lvl,bool isStart) {
  Player player = new Player(0.05 * view.height, 0.50 * view.width);
  final double xSize = 100.0;
  final double ySize = 100.0;

  List<Asteroid> enemies = [
    new Asteroid(1, 0.25 * window.innerWidth, 0.9 * window.innerHeight)];

/*
  List<Enemy> enemiesList = new List<Enemy>();
  Casual Benedikt = new Casual(2, 10.0, 10.0, false);
  enemiesList.add(Benedikt);
  World space = new World(xSize, ySize, thatMe, enemiesList);
  WorldController worldController = new WorldController(space);
  MiniMap mMap = new MiniMap(space);
*/

  var Screen = querySelector("#screen");
  int maxSizeX = Screen.clientWidth;
  int maxSizeY = Screen.clientHeight;
  int ScreenPosX = (maxSizeX / 2).floor();
  int ScreenPosY = (maxSizeY / 2).floor();
  int deltaX = 0;
  int deltaY = 0;
  int hits = 0;
  view.crosshair = querySelector(".cross");
  var ship = querySelector('#player');
  bool mobile = false;

  window.onDeviceOrientation.listen((ev) {
    // No device orientation
    if (ev.alpha == null && ev.beta == null && ev.gamma == null) {
      bool mobile = false;
    }
    // Device orientation available
    else {
      mobile = true;
      /*
      final dy = min(50, max(10, ev.beta)) - 30;
      final dx = min(20, max(-20, ev.gamma));
      */

      //-180, 180
      int ySpeed = 10; // Langsam > Schnell
      if ((ev.beta > 50) && (ScreenPosY > 2)) {
        deltaY -= (ev.beta / ySpeed).floor();
      }
      if ((ev.beta < 40) && (ScreenPosY < (maxSizeY - 56))) {
        if (ev.beta >= 0) {
          deltaY += (ev.beta / ySpeed).floor() + 2;
          deltaY += deltaY == 5
              ? 0
              : deltaY == 4 ? 2 : deltaY == 3 ? 4 : deltaY == 2 ? 6 : -404;
        } else {
          deltaY -= ((ev.beta)).floor() - 6;
        }
      }
      //-90, 90
      int xSpeed = 5;
      if ((ev.gamma < -5) && (ScreenPosX > 2)) {
        deltaX += (ev.gamma / xSpeed).floor() - 2;

        print("Gamma < -5: " + ev.gamma.toString());
      }
      if ((ev.gamma > 5) && (ScreenPosX < (maxSizeX - 13))) {
        deltaX += (ev.gamma / xSpeed).floor() + 2;
        print("Gamma >  5: " + ev.gamma.toString());
      }
      Screen.onTouchStart.listen((e) {
        if(player.shoot(enemies, view.crosshair)) hits++;
      });

      print('DeltaX aus Gamma: ' + deltaX.toString());
      ScreenPosX += deltaX;
      ScreenPosY += deltaY;

      deltaX = 0;
      deltaY = 0;
    }
  });

  if (mobile == false) {
    window.onKeyDown.listen((KeyboardEvent e) {
      if ((e.keyCode == 97 ||
              e.keyCode == KeyCode.A ||
              e.keyCode == KeyCode.LEFT) &&
          ScreenPosX > 9) {
        deltaX -= 9;

        //print(space.player.vector.toString()); //DEBUG VECTOR
      }
      if ((e.keyCode == 100 ||
              e.keyCode == KeyCode.D ||
              e.keyCode == KeyCode.RIGHT) &&
          ScreenPosX < (maxSizeX - 70)) {
        deltaX += 9;

        //print(space.player.vector.toString()); //DEBUG VECTOR
      }
      if ((e.keyCode == 119 ||
              e.keyCode == KeyCode.W ||
              e.keyCode == KeyCode.UP) &&
          ScreenPosY < (maxSizeY - 70)) {
        deltaY += 9;
      }
      if ((e.keyCode == 115 ||
              e.keyCode == KeyCode.S ||
              e.keyCode == KeyCode.DOWN) &&
          ScreenPosY > 9) {
        deltaY -= 9;
      }
      if (e.keyCode == 32) {
        if(player.shoot(enemies, view.crosshair)) hits++;
      }
      ScreenPosX += deltaX;
      ScreenPosY += deltaY;
      deltaX = 0;
      deltaY = 0;
    });
  }
  int n = 0;
  Timer loop;
  Timer tspawn;
  Timer collision;
  tspawn= new Timer.periodic(new Duration(seconds: lvl.spawnTime), (update){
      if(n <= lvl.number*3){
        for (int i = 0; i < lvl.number && lvl.number>enemies.length; i++) {
        double rand = Random.secure().nextDouble();
        if(rand > 0.9) rand = 0.9;
        n++;
        print("Spawn :"+i.toString()+" Rand"+rand.toString() +" Overall:"+n.toString());
        enemies.add(view.spawnAsteroid(rand * window.innerWidth));
        }
      } else {
        if(enemies.length == 0){
          isStart=false;
          tspawn.cancel();
          loop.cancel();
          if(hits == lvl.number * 3){
            view.showEndWin(); 
          }else {
            view.showEndLose();
          }
        }
      }
      view.update(ScreenPosX, ScreenPosY, enemies);
  });
  /*
  gameLoop
   */
  loop = new Timer.periodic(new Duration(milliseconds: 60), (update) {
    ship.style.left = "${ScreenPosX}px";
    view.update(ScreenPosX, ScreenPosY, enemies);
    //mMap.adjust(thatMe, space.enemies);
    // viewController.update();
  });

  collision = new Timer.periodic(new Duration(milliseconds: 20), (update) {
    view.collisionCheck(enemies);
    for(int i = 0; i < enemies.length; i++){
      if(enemies[i].dead == true){
        enemies[i].asteroid.remove();
        enemies.removeAt(i);
      }
    }
  });
}
