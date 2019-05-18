import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'casuals.dart';
import 'enemy.dart';
import 'mini_map.dart';
import 'world.dart';
import 'player.dart';
import 'world_controller.dart';

import 'view.dart';

void main() {
  View view = new View();
  Player thatMe = new Player(40.0, 10.0);
  thatMe.vector.rotate(new Random().nextInt(180));
  final double xSize = 100.0;
  final double ySize = 100.0;

  List<Enemy> enemiesList = new List<Enemy>();
  Casual Benedikt = new Casual(2, 10.0, 10.0, false);
  Benedikt.vector.rotate(new Random().nextInt(45));
  Casual Marco = new Casual(2, 15.0, 15.0, false);
  Marco.vector.rotate(new Random().nextInt(45));
  enemiesList.add(Benedikt);
  enemiesList.add(Marco);
  World space = new World(xSize, ySize, thatMe, enemiesList);
  WorldController worldController = new WorldController(space);
  MiniMap mMap = new MiniMap(space);
<<<<<<< HEAD
  
=======
/*
  List<Asteroid> enemies = [new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.25 * view.width), (0.80 * view.height), view),
  new Asteroid((0.05 * view.width), (0.90 * view.height), view), new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.15 * view.width), (0.85 * view.height), view)];
*/
>>>>>>> 82c09bcfe78c7a494b010f19e9c0f2039fdb30d8
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
        if(ev.beta >= 0){
          deltaY += (ev.beta/ySpeed).floor()+2;
          deltaY += deltaY == 5 ? 0 : deltaY == 4 ? 2 : deltaY == 3 ? 4 : deltaY == 2 ? 6 : -404 ;
        } else{
          deltaY -= ((ev.beta)).floor()-6;
        }
      }
      //-90, 90
      int xSpeed = 5;
      if((ev.gamma < -5 )&&( ScreenPosX > 2)){
        deltaX += (ev.gamma /xSpeed).floor()-2;

        print("Gamma < -5: "+ev.gamma.toString());
      }
      if((ev.gamma > 5 )&&( ScreenPosX < (maxSizeX-13))){
        deltaX += (ev.gamma /xSpeed).floor()+2;
        print("Gamma >  5: "+ev.gamma.toString());
      }
      print('DeltaX aus Gamma: '+deltaX.toString());
      ScreenPosX += deltaX;
      ScreenPosY += deltaY;
      deltaX = 0;
      deltaY = 0;
    }
  });


  /* Keyboard Kontrolle */
  if(mobile == false){
<<<<<<< HEAD
  window.onKeyDown.listen((KeyboardEvent e) {
    if ((e.keyCode == 97 ||e.keyCode == KeyCode.A || e.keyCode == KeyCode.LEFT) &&ScreenPosX > 2) {        
       deltaX -= 3;
    }
     else if ((e.keyCode == 100 ||e.keyCode == KeyCode.D || e.keyCode == KeyCode.RIGHT)&&ScreenPosX < (maxSizeX-70)) {
       deltaX += 3;
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
    deltaX = 0;
    deltaY = 0;
  });
=======
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
>>>>>>> 82c09bcfe78c7a494b010f19e9c0f2039fdb30d8
  }

  /* GameLoop */
  new Timer.periodic(new Duration(milliseconds: 30), (update) {
    view.update(ScreenPosX, ScreenPosY);
    ship.style.left = "${ScreenPosX}px";
<<<<<<< HEAD
=======
    view.update(ScreenPosX, ScreenPosY);
>>>>>>> 82c09bcfe78c7a494b010f19e9c0f2039fdb30d8
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
}

