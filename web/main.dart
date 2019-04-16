import 'dart:html';
import 'dart:svg' as svg;
import 'dart:math' as math;

import 'MotionView.dart' as mv;
import 'Vector.dart';
import 'World.dart';

void main() {

}

class Space {
  //Set sizes at start etc
  double x_size_max;
  double y_size_max;
  Player current_player;
  Space(this.x_size_max, this.y_size_max, this.current_player);

  //Function to simulate the space for every frame(Kommt noch)
  void simulate() {}
}

class Player {
  //Current position
  double x_pos_curr;
  double y_pos_curr;
  //Current health
  int health = 6;
  Player(this.x_pos_curr, this.y_pos_curr);
}


