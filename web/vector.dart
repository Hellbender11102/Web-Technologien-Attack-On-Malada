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

  //Function for Displaying Units. x1,y1 for curr Pos. x3,y3 for Point coords
  double shortestDistance(double x1, double y1, int renderDistance, double x3, double y3){
    double px = (this.dx * renderDistance) - x1;
    double py = (this.dy * renderDistance) - y1;
    double temp = (px * px) + (py * py);
    double u = ((x3 - x1) * px + (y3 - y1) * py) / (temp);
    if(u > 1) {
        u = 1;
    }
    else if(u < 0){
        u = 0;
    }
    double x = x1 + u * px;
    double y = y1 + u * py;

    double dx = x - x3;
    double dy = y - y3;
    double dist = math.sqrt(dx * dx + dy * dy);
    return dist;
  }
 
  //toString for debug purpose
  String toString() => "($dx, $dy)";
}