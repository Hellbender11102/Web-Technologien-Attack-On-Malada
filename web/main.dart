import 'dart:async';
import 'dart:html';
import 'Casuals.dart';
import 'Enemy.dart';
import 'World.dart';
import 'Player.dart';
import 'InputController.dart';


void main() {
  var playerDot = querySelector(".playerOnMap");
  InputController input;
/*
  curr_pos / max_size = %
*/

  double xSize = 4.0;
  double ySize = 4.0;
  Player thatMe = new Player(1.0, 2.0);
  List<Enemy> enemiesList = new List();
  enemiesList.add(new Casual(2, 3.0, 3.0, false));
  World space = new World(xSize, ySize, thatMe, enemiesList);

  double x = ((thatMe.curr_pos_X / xSize) * 100);
  double y = ((thatMe.curr_pos_Y / ySize) * 100);

  new Timer.periodic(new Duration(milliseconds: 30), (update) {
    x = ((thatMe.curr_pos_X / xSize) * 100);
    y = ((thatMe.curr_pos_Y / ySize) * 100);
    playerDot.style.left = '$x%';
    playerDot.style.bottom = '$y%';
    thatMe.move();
    /* 
      worldController.simulate();
      mMap.adjust();
      viewController.update();
     */
  });

  /*
  var Minimap = querySelector("minimap");
  ImageElement imEle = 
  Minimap.append(node)


  Player thatMe = new Player(1.0, 2.0);
  List<Enemy> enemiesList = new List();
  enemiesList.add(new Casual(2, 3.0, 3.0, false));
  World space = new World(4.0, 4.0, thatMe, enemiesList);

  new Timer.periodic(new Duration(milliseconds: 30), (update) {
    space.simulate();
  });

  */
   
}

