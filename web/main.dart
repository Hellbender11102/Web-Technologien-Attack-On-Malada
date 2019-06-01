import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'model/casuals.dart';
import 'model/enemy.dart';
import 'model/level.dart';
import 'model/mini_map.dart';
import 'model/world.dart';
import 'model/player.dart';
import 'controller/world_controller.dart';
import 'model/asteroid.dart';
import 'dart:convert' as JSON;
import 'view/view.dart';
import 'dart:math' as math;

void main() {
  String lvl1 =
      '{"fortschritt": 0,"name": "Aller","spawnTime": 2,"numberOnScreen":5,"type":["asteroid","casual"],"numberTilFinish":20}';
  String lvl2 =
      '{"fortschritt": 1,"name": "Anfang","spawnTime": 1,"numberOnScreen":10,"type":["asteroid","casual"],"numberTilFinish":40}';
  String lvl3 =
      '{"fortschritt": 1,"name": "ist","spawnWidth": 100,"spawnTime": 3,"number":20,"enemies":[{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1}]}';
  String lvl4 =
      '{"fortschritt": 1,"name": "schwer","spawnWidth": 100,"spawnTime": 2,"number":40,"enemies":[{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1},{"curr_pos_X":100,"curr_pos_Y":100,"life":2,"damage":1}]}';
  Map<String, dynamic> lvlMap;
  Level lvl;
  View view = new View();
  bool isStarted = false;
  int level = 0;
  view.startBtn.onTouchEnd.listen((e) {
    view.screen.children.remove(view.startBtn);
    view.showLevelMenu();
  });
  view.startBtn.onClick.listen((e) {
    view.screen.children.remove(view.startBtn);
    view.showLevelMenu();
  });
  view.l1.onClick.listen((e) {
    level = 1;
    view.screen.children.remove(view.l1);
    view.screen.children.remove(view.l2);
    lvlMap = level == 1 ? JSON.jsonDecode(lvl1) : JSON.jsonDecode(lvl2);
    lvl = Level.fromJson(lvlMap);
    start(view, lvl, isStarted);
  });
  view.l2.onClick.listen((e) {
    level = 2;
    view.screen.children.remove(view.l1);
    view.screen.children.remove(view.l2);
    lvlMap = level == 1 ? JSON.jsonDecode(lvl1) : JSON.jsonDecode(lvl2);
    lvl = Level.fromJson(lvlMap);
    start(view, lvl, isStarted);
  });
}

void start(View view, Level lvl, bool isStart) {
  World space;
  WorldController worldController;
  MiniMap mMap;
  Player thatMe = new Player(0.05 * view.height, 0.50 * view.width);
  thatMe.vector.rotate(new Random().nextInt(180));
  final double xSize = 100.0;
  final double ySize = 100.0;

  List<Asteroid> enemies = [
    new Asteroid(1, 0.25 * window.innerWidth, 0.9 * window.innerHeight)
  ];

/*
  List<Enemy> enemiesList = new List<Enemy>();
  Casual Benedikt = new Casual(2, 10.0, 10.0, false);
  Benedikt.vector.rotate(new Random().nextInt(45));
  Casual Marco = new Casual(2, 15.0, 15.0, false);
  Marco.vector.rotate(new Random().nextInt(45));
  enemiesList.add(Benedikt);
  enemiesList.add(Marco);
  World space = new World(xSize, ySize, thatMe, enemiesList);
  WorldController worldController = new WorldController(space, view);
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

        gamma = ev.gamma;
        beta = ev.beta;
        deltaY = math.pow((beta+ 35),3)*0.25;
        deltaX = math.pow(gamma,3)*0.25;
        deltaY = deltaY.abs() < maxSizeY ? deltaY : maxSizeY;
        deltaX = deltaX.abs() < maxSizeX ? deltaX : maxSizeX;
      */

      //-180, 180
      /*
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
      */
      double xPos;
      if(gamma > 0)
       { xPos = (50*(((100/90)*ev.gamma)/100))+50;}
  if(gamma < 0)
       { xPos = (-50*(((100/90)*ev.gamma)/100))+50;}

        deltaY = math.pow((ev.beta+ 35),3)*0.25;
        deltaX = math.pow(ev.gamma,3)*0.25;
        deltaY = deltaY.abs() < maxSizeY ? deltaY : maxSizeY;
        deltaX = deltaX.abs() < maxSizeX ? deltaX : maxSizeX;
      Screen.onTouchStart.listen((e) {
        if (thatMe.shoot(enemies, view.crosshair) == true) hits++;
      });

      print('DeltaX aus Gamma: ' + deltaX.toString());
      //ScreenPosX = deltaX;
      ScreenPosX = xPos;
      ScreenPosY = deltaY;

      deltaX = 0;
      deltaY = 0;
    }
  });

  if (mobile == false) {
    window.onKeyDown.listen((KeyboardEvent e) {
      if ((e.keyCode == 97 ||
              e.keyCode == KeyCode.A ||
              e.keyCode == KeyCode.LEFT) &&
          ScreenPosX > 11) {
        deltaX -= 11;

        //print(space.player.vector.toString()); //DEBUG VECTOR
      }
      if ((e.keyCode == 100 ||
              e.keyCode == KeyCode.D ||
              e.keyCode == KeyCode.RIGHT) &&
          ScreenPosX < (maxSizeX - 70)) {
        deltaX += 11;

        //print(space.player.vector.toString()); //DEBUG VECTOR
      }
      if ((e.keyCode == 119 ||
              e.keyCode == KeyCode.W ||
              e.keyCode == KeyCode.UP) &&
          ScreenPosY < (maxSizeY - 70)) {
        deltaY += 11;
      }
      if ((e.keyCode == 115 ||
              e.keyCode == KeyCode.S ||
              e.keyCode == KeyCode.DOWN) &&
          ScreenPosY > 11) {
        deltaY -= 11;
      }
      if (e.keyCode == 32) {
        if (thatMe.shoot(enemies, view.crosshair) == true) hits++;
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
  tspawn = new Timer.periodic(new Duration(seconds: lvl.spawnTime), (update) {
    if (n <= lvl.numberTilFinish &&
        (n + (5 - enemies.length)) <= lvl.numberTilFinish) {
      for (int i = 0;
          i < lvl.numberOnScreen && lvl.numberOnScreen > enemies.length;
          i++) {
        double rand = Random.secure().nextDouble();
        if (rand > 0.9) rand = 0.9;
        n++;
        print("Spawn :" +
            i.toString() +
            " Rand" +
            rand.toString() +
            " Overall:" +
            n.toString());
        enemies.add(view.spawnAsteroid(rand * window.innerWidth));
      }
    } else {
      if (enemies.length == 0) {
        isStart = false;
        if (hits == lvl.numberTilFinish) {
          view.showEndWin();
        } else {
          view.showEndLose();
        }
        tspawn.cancel();
        loop.cancel();
      }
    }
    view.update(ScreenPosX, ScreenPosY, enemies);
    mMap.adjust(thatMe, space.enemies);
  });
  /*
  gameLoop
   */
  loop = new Timer.periodic(new Duration(milliseconds: 60), (update) {
    ship.style.left = "${ScreenPosX}px";
    view.update(ScreenPosX, ScreenPosY ,enemies);
    mMap.adjust(thatMe, space.enemies);
  });

  new Timer.periodic(new Duration(milliseconds: 60), (update) {
    worldController.simulate();
  });

  new Timer.periodic(new Duration(milliseconds: 240), (update) {
    for(Enemy e in worldController.getEnemiesFromWorld()){
      if(new Random().nextInt(10) < 2){
        e.vector.rotate(new Random().nextInt(90) - 45);
      }
    }
  });

  collision = new Timer.periodic(new Duration(milliseconds: 20), (update) {
    view.collisionCheck(enemies);
    for (int i = 0; i < enemies.length; i++) {
      if (enemies[i].dead == true) {
        enemies[i].asteroid.remove();
        enemies.removeAt(i);
      }
    }
  });
}

void restart(View view, Level lvl) {
  view.restart.onTouchStart.listen((e) {
    view.screen.children.remove(restart);
    View viewNew = new View();
    start(viewNew, lvl, false);
  });
  view.restart.onClick.listen((e) {
    view.screen.children.remove(restart);
    View viewNew = new View();
    start(viewNew, lvl, false);
  });
}
