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
  int ScreenPosX = 50;
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
      final dy = min(50, max(10, ev.beta)) - 30;
      final dx = min(20, max(-20, ev.gamma));
      ScreenPosX =-dx;
       ship.style.left = '${(ScreenPosX)}%';
    }
  });

  if(mobile == false){
  window.onKeyPress.listen((KeyboardEvent e) {
    if ((e.keyCode == 97 ||e.keyCode == KeyCode.A) &&ScreenPosX > 0) {        
       ScreenPosX -=1;
        ship.style.left = '${(ScreenPosX)}%';
        
       print(space.player.vector.toString());
    }
     if ((e.keyCode == 100 ||e.keyCode == KeyCode.D)&&ScreenPosX < 93) {
       ScreenPosX +=1;
       ship.style.left = '${(ScreenPosX)}%';
       
       print(space.player.vector.toString());
    }
  });
  }

  thatMe.vector.rotate(new Random().nextInt(45));
  /* GameLoop */
  new Timer.periodic(new Duration(milliseconds: 120), (update) {

    view.update(ScreenPosX);
    //view.update(cross, enemies);
    mMap.adjust(thatMe, space.enemies);
    // viewController.update();
  });
}

