import 'dart:async';
import 'dart:html';
import 'Casuals.dart';
import 'Enemy.dart';
import 'MiniMap.dart';
import 'World.dart';
import 'Player.dart';
import 'InputController.dart';
import 'WorldController.dart';

import 'View.dart';

void main() {
  var playerDot = querySelector(".playerOnMap");
  InputController input;

  final view = new View();
  final Player thatMe = new Player(40.0, 0.0);
  final double xSize = 50.0;
  final double ySize = 50.0;

  Cross cross = new Cross(view.center_x, view.center_y, view);
  List<Asteroid> enemies = [new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.05 * view.width), (0.95 * view.height), view), 
  new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.05 * view.width), (0.95 * view.height), view), new Asteroid((0.05 * view.width), (0.95 * view.height), view)];

  view.update(cross, enemies);



  List<Enemy> enemiesList = new List();
  enemiesList.add(new Casual(2, 10.0, 10.0, false));
  World space = new World(xSize, ySize, thatMe, enemiesList);
  WorldController worldController = new WorldController(space);
  final MiniMap mMap = new MiniMap(space);


  /* GameLoop */
  new Timer.periodic(new Duration(milliseconds: 30), (update) {
    print("LOOP");
    window.onKeyPress.listen((KeyboardEvent e) {
     window.console.log("Pressed");

      if (e.keyCode == KeyCode.A) {
        var player = querySelector("#player");
        player.style.left = '1px';
        player.style.width = '100%';
        window.console.log("Pressed A");
      }
    });

    
    thatMe.move();
      worldController.simulate();
      mMap.adjust(thatMe, space.enemies);
     // viewController.update();
  });
}

