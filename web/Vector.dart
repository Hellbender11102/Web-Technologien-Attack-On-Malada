import 'dart:math' as math;

class Vector {
  //2 Dimensional dx, dy
  //should be between -1 to 1
  double dx;
  double dy;
  Vector(this.dx, this.dy);

  //Functions to rotate clockwise/counter-clockwise
  //we'll use some math for this (oh geez!)
  //names not right yet
  void rotate_counter_clockwise(int betaDegree) {
    this.dx = math.cos(betaDegree) * this.dx - math.sin(betaDegree) * this.dy;
    this.dy = math.sin(betaDegree) * this.dx + math.cos(betaDegree) * this.dy;
  }

  String toString() => "($dx, $dy)";
}