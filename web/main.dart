import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'casuals.dart';
import 'enemy.dart';
import 'mini_map.dart';
import 'world.dart';
import 'player.dart';
import 'world_controller.dart';
import 'asteroid.dart';

import 'view.dart';

void main() {
  View view = new View();
  view.startBtn.onTouchEnd.listen((e) {
    Player thatMe = new Player(0.05 * view.height, 0.50 * view.width);
    final double xSize = 100.0;
    final double ySize = 100.0;

    List<Asteroid> enemies = [
      new Asteroid(1, 0.25 * window.innerWidth, 0.9 * window.innerHeight),
      new Asteroid(1, 0.8 * window.innerWidth, 0.7 * window.innerHeight),
      new Asteroid(1, 0.45 * window.innerWidth, 0.8 * window.innerHeight),
      new Asteroid(1, 0.65 * window.innerWidth, 0.85 * window.innerHeight),
      new Asteroid(1, 0.78 * window.innerWidth, 0.9 * window.innerHeight),
      new Asteroid(1, 0.1 * window.innerWidth, 0.95 * window.innerHeight)
    ];

    List<Enemy> enemiesList = new List<Enemy>();
    Casual Benedikt = new Casual(2, 10.0, 10.0, false);
    enemiesList.add(Benedikt);
    World space = new World(xSize, ySize, thatMe, enemiesList);
    WorldController worldController = new WorldController(space);
    MiniMap mMap = new MiniMap(space);

    var Screen = querySelector("#screen");
    int maxSizeX = Screen.clientWidth;
    int maxSizeY = Screen.clientHeight;
    int ScreenPosX = (maxSizeX / 2).floor();
    int ScreenPosY = (maxSizeY / 2).floor();
    int deltaX = 0;
    int deltaY = 0;
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
          thatMe.shoot(enemies, view.crosshair);
        });

        print('DeltaX aus Gamma: ' + deltaX.toString());
        ScreenPosX += deltaX;
        ScreenPosY += deltaY;
        view.update(ScreenPosX, ScreenPosY, enemies);
        deltaX = 0;
        deltaY = 0;
      }
    });

    if (mobile == false) {
      window.onKeyDown.listen((KeyboardEvent e) {
        if ((e.keyCode == 97 ||
                e.keyCode == KeyCode.A ||
                e.keyCode == KeyCode.LEFT) &&
            ScreenPosX > 2) {
          deltaX -= 3;

          print(space.player.vector.toString()); //DEBUG VECTOR
        } else if ((e.keyCode == 100 ||
                e.keyCode == KeyCode.D ||
                e.keyCode == KeyCode.RIGHT) &&
            ScreenPosX < (maxSizeX - 70)) {
          deltaX += 3;

          print(space.player.vector.toString()); //DEBUG VECTOR
        }
        if ((e.keyCode == 119 ||
                e.keyCode == KeyCode.W ||
                e.keyCode == KeyCode.UP) &&
            ScreenPosY < (maxSizeY - 70)) {
          deltaY += 3;
        } else if ((e.keyCode == 115 ||
                e.keyCode == KeyCode.S ||
                e.keyCode == KeyCode.DOWN) &&
            ScreenPosY > 5) {
          deltaY -= 3;
        } else if (e.keyCode == 32) {
          thatMe.shoot(enemies, view.crosshair);
        }
        ScreenPosX += deltaX;
        ScreenPosY += deltaY;
        view.update(ScreenPosX, ScreenPosY, enemies);
        deltaX = 0;
        deltaY = 0;
      });
    }
    /* GameLoop */
    new Timer.periodic(new Duration(milliseconds: 60), (update) {
      ship.style.left = "${ScreenPosX}px";
      view.update(ScreenPosX, ScreenPosY, enemies);
      mMap.adjust(thatMe, space.enemies);
      // viewController.update();
    });
  });
}
