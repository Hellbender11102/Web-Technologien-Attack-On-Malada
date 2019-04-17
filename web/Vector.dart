import 'dart:math' as math;

//This Class is still WIP and not tested
//I call all the Lazy-Rangers for this! Lend me your strength!
class Vector {
  //2 Dimensional dx, dy
  //should be between -1 to 1
  //length should stay one!
  double dx;
  double dy;
  Vector(this.dx, this.dy);

  //Functions to rotate clockwise/counter-clockwise
  //we'll use some math for this (oh geez!)
  //names not right yet
  void rotate_counter_clockwise(int betaDegree) {
    betaDegree = betaDegree%360;
    this.dx = math.cos(betaDegree) * this.dx - math.sin(betaDegree) * this.dy;
    this.dy = math.sin(betaDegree) * this.dx + math.cos(betaDegree) * this.dy;
  }

  void invertX(){
    this.dx = -this.dx;
  }
  void invertY(){
    this.dy = -this.dy;
  }

  //toString for debug purpose
  String toString() => "($dx, $dy)";
}