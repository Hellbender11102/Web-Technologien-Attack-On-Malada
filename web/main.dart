import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'Casuals.dart';
import 'Enemy.dart';
import 'MiniMap.dart';
import 'World.dart';
import 'Player.dart';
import 'WorldController.dart';

import 'View.dart';

void main() {
  View view = new View();
  Player thatMe = new Player(40.0, 10.0);
  final double xSize = 100.0;
  final double ySize = 100.0;

  List<Enemy> enemiesList = new List<Enemy>();
  Casual Benedikt = new Casual(2, 10.0, 10.0, false);
  enemiesList.add(Benedikt);
  World space = new World(xSize, ySize, thatMe, enemiesList);
  WorldController worldController = new WorldController(space);
  MiniMap mMap = new MiniMap(space);
/*
  List<Asteroid> enemies = [new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.25 * view.width), (0.80 * view.height), view), 
  new Asteroid((0.05 * view.width), (0.90 * view.height), view), new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.15 * view.width), (0.85 * view.height), view)];
*/
  var Screen = querySelector("#screen");
  int maxSizeX = Screen.clientWidth;
  int maxSizeY = Screen.clientHeight;
  int ScreenPosX = (maxSizeX / 2).floor();
  int ScreenPosY = (maxSizeY / 2).floor();
  int deltaX = 0;
  int deltaY = 0;
  var cross = querySelector('.cross');
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
       int ySpeed = 10;// Langsam > Schnell
      if((ev.beta > 50 )&&( ScreenPosY > 2)){
        deltaY -= (ev.beta/ySpeed).floor();
      }
      if((ev.beta < 40 )&&( ScreenPosY < (maxSizeY-56))){
        if(ev.beta > 1){
          deltaY += (ev.beta/ySpeed).floor();
        } else{
          deltaY -= ((ev.beta-10)).floor();
        }
      }

      //-90, 90
      int xSpeed = 5;// Langsam > Schnell
      if((ev.gamma < 5 )&&( ScreenPosX > 2)){
          deltaX += (ev.gamma /xSpeed).floor();
      }
      if((ev.gamma > -5 )&&( ScreenPosX < (maxSizeX-13))){
          deltaX += (ev.gamma /xSpeed).floor();
      }
      ScreenPosX += deltaX;
      ScreenPosY += deltaY;
      view.update(ScreenPosX, ScreenPosY);
      deltaX = 0;
      deltaY = 0;
    }
  });

  if(mobile == false){
  window.onKeyDown.listen((KeyboardEvent e) {
    if ((e.keyCode == 97 ||e.keyCode == KeyCode.A || e.keyCode == KeyCode.LEFT) &&ScreenPosX > 2) {        
       deltaX -= 3;
        
       print(space.player.vector.toString()); //DEBUG VECTOR
    }
     else if ((e.keyCode == 100 ||e.keyCode == KeyCode.D || e.keyCode == KeyCode.RIGHT)&&ScreenPosX < (maxSizeX-70)) {
       deltaX += 3;
    
       print(space.player.vector.toString()); //DEBUG VECTOR
    }
      if ((e.keyCode == 119 ||e.keyCode == KeyCode.W || e.keyCode == KeyCode.UP) &&ScreenPosY < (maxSizeY-70)) {        
       deltaY += 3;
    }
      else if ((e.keyCode == 115 ||e.keyCode == KeyCode.S || e.keyCode == KeyCode.DOWN) &&ScreenPosY > 5) {        
       deltaY -= 3;
    }
  
    else if (e.keyCode == 32) {
       print("SpaceBar");
    }
    ScreenPosX += deltaX;
    ScreenPosY += deltaY;
    view.update(ScreenPosX, ScreenPosY);
    deltaX = 0;
    deltaY = 0;
  });
  }
  /* GameLoop */
  new Timer.periodic(new Duration(milliseconds: 120), (update) {
    ship.style.left = "${ScreenPosX}px";
   // view.update(ScreenPosX, ScreenPosY); doppelt
    mMap.adjust(thatMe, space.enemies);
    // viewController.update();
  });
}

