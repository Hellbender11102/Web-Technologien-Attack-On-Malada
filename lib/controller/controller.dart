import 'dart:async';

import '../model/level.dart';
import '../model/mini_map.dart';
import '../model/player.dart';
import '../model/world.dart';
import 'world_controller.dart';
import 'dart:html';
import 'dart:math';
import '../view/view.dart';
import 'dart:convert' as JSON;
import '../model/vector.dart';
import '../model/enemy.dart';
import '../model/casual.dart';
import '../model/shot.dart';
import '../model/elite.dart';

class Controller {
  World world;
  WorldController worldCon;
  Level level;
  View view;
  MiniMap miniMap;
  Player player;
  int currLevel;
  var Screen = querySelector("#screen");
  var ship = querySelector("#player");
  int maxSizeX = querySelector("#screen").clientWidth;
  int maxSizeY = querySelector("#screen").clientHeight;
  //int ScreenPosX = (maxSizeX / 2).floor();
  //int ScreenPosY = (maxSizeY / 2).floor();
  int deltaX = 0;
  int deltaY = 0;
  Timer gameLoop;
  Timer worldLoop;
  Timer collision;
  Timer shots;

  Controller(this.view, int level) {
    currLevel = level;
    switch (currLevel) {
        case 5:
          {
            this.loadLevel("level/level5.json");
          }
          break;

        case 4:
          {
            this.loadLevel("level/level4.json");
          }
          break;

        case 3:
          {
            this.loadLevel("level/level3.json");
          }
          break;

        case 2:
          {
            this.loadLevel("level/level2.json");
          }
          break;

        case 1:
          {
            this.loadLevel("level/level1.json");
          }
          break;
    }
    this.view.crosshair = querySelector(".cross");
    view.startBtn.onClick.listen((e) {
      view.screen.children.remove(view.startBtn);
      startGame();
    });
    view.startBtn.onTouchEnd.listen((e) {
      view.screen.children.remove(view.startBtn);
      startGame();
    });
  }

  void startGame() async {
    player = new Player(level.maxX / 2, 40.0);
    this.world = World(
        level.maxX as double, level.maxY as double, player, level.enemyList());
    world.setLevel(level);
    worldCon = new WorldController(this.world, this.view);
    miniMap = new MiniMap(this.world);
    gamstage();
  }

  void gamstage() {
    List<Shot> shotList = new List();
    double xPos = 0.0;
    double yPos = 0.0;
    int crossX = (maxSizeX / 2).round(), crossY = (maxSizeY / 2).round();

    window.onDeviceOrientation.listen((ev) {
      if (ev.beta != null && ev.gamma != null) {
        Screen.onTouchStart.listen((e) {
          player.shoot(world.enemies, view.crosshair, miniMap);
        });

        window.onDeviceOrientation.listen((ev) {
          int halfX = (maxSizeX / 2).round();
          if (ev.gamma >= 0) {
            xPos = halfX * (ev.gamma / 30);
          } else {
            xPos = halfX * (ev.gamma / 30);
          }
          xPos += halfX;
          player.vector.rotate((ev.gamma * 1.125).floor());
          yPos = maxSizeY * (ev.beta / -60);
          yPos += maxSizeY;

          yPos = maxSizeY - 30 <= yPos ? maxSizeY - 30 : yPos <= 0 ? 0 : yPos;
          xPos = maxSizeX - 30 <= xPos ? maxSizeX - 30 : xPos <= 0 ? 0 : xPos;
          crossX = xPos.round();
          crossY = yPos.round();
        });
      }
    });

    window.onKeyDown.listen((KeyboardEvent e) {
      print(e.keyCode.toString() + " keycode");
      if (e.keyCode == 97 ||
          e.keyCode == KeyCode.A ||
          e.keyCode == KeyCode.LEFT) {
        xPos -= 25;
      } else if (e.keyCode == 100 ||
          e.keyCode == KeyCode.D ||
          e.keyCode == KeyCode.RIGHT) {
        xPos += 25;
      }
      if (e.keyCode == 115 ||
          e.keyCode == KeyCode.S ||
          e.keyCode == KeyCode.DOWN) {
        yPos -= 25;
      } else if (e.keyCode == 119 ||
          e.keyCode == KeyCode.W ||
          e.keyCode == KeyCode.UP) {
        yPos += 25;
      }
      if (e.keyCode == 32) {
        player.shoot(world.enemies, view.crosshair, miniMap);
      }
      if (crossX >= maxSizeX / 2) {
        player.vector.rotate((25 * 1.125).floor());
      } else {
        player.vector.rotate((-25 * 1.125).floor());
      }
      crossY += yPos.round() + crossY > maxSizeY - 70
          ? 0
          : yPos.round() + crossY > 0 ? yPos.round() : 0;
      crossX += xPos.round() + crossX > maxSizeX - 70
          ? 0
          : xPos.round() + crossX > 0 ? xPos.round() : 0;
      xPos = 0.0;
      yPos = 0.0;
    });

    double sinTemp = 0;
    gameLoop = new Timer.periodic(new Duration(milliseconds: 60), (update) {
      ship.style.left = "${crossX}px";
      ship.style.bottom = "${sin(sinTemp)*10+30}px";
      sinTemp >= 6.28 ? sinTemp = 0.00 : sinTemp += 0.1 ;
      player.curr_pos_X = crossX as double;
      view.update(crossX, crossY, world.enemies);
      view.updateShots(shotList);
      worldCon.simulate();
      miniMap.adjust(player, world.enemies);
    });

    worldLoop = new Timer.periodic(new Duration(milliseconds: 30), (update) {
      for (Enemy e in worldCon.isInPlayerView()) {
        Vector temp = worldCon.getXYFromPlayer(e);
        // view.showOnScreen(e, temp.dx, temp.dy);
      }
      // worldCon.displayEnemiesInView(world.enemies);
    });

    collision = new Timer.periodic(new Duration(milliseconds: 10), (update) {
      view.collisionCheck(world.enemies, player);
      view.collisionCheckShots(shotList, player);
      for (int i = 0; i < world.enemies.length; i++) {
        if (world.enemies[i].isDead()) {
          world.enemies[i].getImage().remove();
          miniMap.deletDot(i);
          world.enemies.removeAt(i);
          player.life--;
        }
      }
      if (view.noHpLeft == true) {
        lose();
      } else if (world.enemies.isEmpty && view.noHpLeft == false) {
        win();
      }
    });

    shots = new Timer.periodic(new Duration(seconds: 2), (update) {
      for (int i = 0; i < world.enemies.length; i++) {
        if (world.enemies[i] is Casual || world.enemies[i] is Elite) {
          if (world.enemies[i].isInView() == true) {
            shotList.add(world.enemies[i].shoot());
            print(shotList.toString());
          }
        }
      }
    });
  }

  void loadLevel(String levelName) async {
    await HttpRequest.getString(levelName).then((json) {
      Map<String, dynamic> lvlMap = JSON.jsonDecode(json);
      this.level = Level.fromJson(lvlMap);
    });
  }

  void lose() {
    shots.cancel();
    gameLoop.cancel();
    collision.cancel();
    worldLoop.cancel();
    view.showEndLose();


    view.restart.onTouchStart.listen((e) {
      view.screen.children.remove(view.restart);
      view.screen.children.remove(view.lose);
      view.screen.children.remove(view.life);
      view.screen.children.remove(view.crosshair);
      miniMap.playerDot.remove();
      for(Enemy e in world.enemies){
        querySelector("#screen").children.removeWhere((x) => x.className == "enemy_asteroid");
        world.enemies.remove(e);
      }
      for(int i = 0; i < miniMap.enemyDots.length; i++){
        miniMap.enemyDots[i].remove();
      }
      new Controller(new View(), 1);
    });


    view.restart.onClick.listen((e) {
      view.screen.children.remove(view.restart);
      view.screen.children.remove(view.lose);
      view.screen.children.remove(view.life);
      view.screen.children.remove(view.crosshair);
      miniMap.playerDot.remove();
      for(Enemy e in world.enemies){
        querySelector("#screen").children.removeWhere((x) => x.className == "enemy_asteroid");
        world.enemies.remove(e);
      }
      for(int i = 0; i < miniMap.enemyDots.length; i++){
        miniMap.enemyDots[i].remove();
      }
      new Controller(new View(), 1);
    });
  }

  void win() {
    shots.cancel();
    gameLoop.cancel();
    collision.cancel();
    worldLoop.cancel();
    view.showEndWin();
    view.next.onTouchStart.listen((e) {
      view.screen.children.remove(view.next);
      view.screen.children.remove(view.win);
      view.screen.children.remove(view.life);
      view.screen.children.remove(view.crosshair);
      miniMap.playerDot.remove();
      currLevel++;
      new Controller(new View(), currLevel);
    });
    view.next.onClick.listen((e) {
      view.screen.children.remove(view.next);
      view.screen.children.remove(view.win);
      view.screen.children.remove(view.life);
      view.screen.children.remove(view.crosshair);
      miniMap.playerDot.remove();
      currLevel++;
      new Controller(new View(), currLevel);
    });
  }
}
