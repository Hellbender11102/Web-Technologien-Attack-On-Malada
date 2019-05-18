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
  void rotate(int Theta) {
    if(Theta < 0) Theta + 360;
    double tempX;
    double tempY;
    tempX = math.cos(Theta) * this.dx - math.sin(Theta) * this.dy;
    tempY = math.sin(Theta) * this.dx + math.cos(Theta) * this.dy;
    this.dx = tempX;
    this.dy = tempY;
  }
  //invert for the world borders
  void invertX(){
    this.dx = -this.dx;
  }
  void invertY(){
    this.dy = -this.dy;
  }
  //toString for debug purpose
  String toString() => "($dx, $dy)";
}