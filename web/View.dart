import 'dart:html';
import 'dart:math';


class View{
  var screen = querySelector("#screen");
  var player = querySelector("#player");
  var cross = querySelector("#cross");
  /**
   * Breite des Views
   */
  int get width => window.innerWidth;
  /**
   * Höhe des Views
   */
  int get height => window.innerHeight;

  
  double get center_x => this.width / 2;

  double get center_y => this.height / 2;

  ImageElement crosshair = new ImageElement();
  double cross_x;
  double cross_y;


  View(){
    this.crosshair.src = "Assets/cross.png";
    this.crosshair.className = "cross";
    this.crosshair.style.position = "absolute";
    this.crosshair.style.bottom = "${cross_y}px";
    this.crosshair.style.left = "${cross_x}px";
    this.screen.children.add(crosshair);
    
    cross_x = center_x;
    cross_y = center_y;
  }

  void update(int shipPos){
    this.crosshair = querySelector(".cross");
    this.crosshair.style.bottom = "${cross_y}px";
    this.crosshair.style.left = "${shipPos}%";
  }
}

/*
class View{
  /**
   * Html Element vom Screen
   */
  final screen = querySelector("#screen");
  /**
  * Html Element vom Spieler 
  */
  final player = querySelector("#player");

  final cross = querySelector("#cross");

  final background = querySelector("#background");

  final asteroid = querySelector("#enemy_asteroid");
  /**
   * Breite des Views
   */
  int get width => window.innerWidth;
  /**
   * Höhe des Views
   */
  int get height => window.innerHeight;
  /**
   * Größe des Views
   */
  int get size => min(this.width, this.height);

  double get center_x => this.width / 2;

  double get center_y => this.height / 2;

  ImageElement crosshair = new ImageElement();

  View(){
    this.crosshair.src = "Assets/cross.png";
    this.crosshair.className = "cross";
    background.children.add(crosshair);
  }
  void update(Cross c, List<Asteroid> a){
    c.update();
    /**
     * 
    for(int i = 0; i < a.length; i++){
      a[i].update();
      if(a[i].isHit()){
        this.asteroid.classes.add('hit');
        this.asteroid.classes.remove('hit');
      }
      this.asteroid.style.top = "${a[i].curr_y}px";
      this.asteroid.style.left = "${a[i].curr_x}px";
      this.asteroid.style.height = "${44}px";
      this.asteroid.style.width = "${45}px";
    }
    */

    this.crosshair.style.top = "${c.curr_y}px";
    this.crosshair.style.left = "${c.curr_x}px";
  }
}

class Cross{
  double x;
  double y;
  double dx = 0;
  double dy = 0;

  View view;

  Cross(double x , double y, View view){
    this.x = x;
    this.y = y;
    this.view = view;
  }

  String toString(){
    return 'Cross: X:$x Y:$y';
  }

  void move(dx, dy){
    if((this.dx += dx) < view.screen.clientWidth && (this.dx += dx) > 0){
      this.dx = dx;
    }
    if((this.dy += dy) < view.screen.clientHeight && (this.dy += dy) > 0){
      this.dy = dy;
    }
  }

  void update(){
    this.x += dx;
    this.y += dy;
  }

  double get curr_x => this.x;

  double get curr_y => this.y;

  bool isEnemyInScope(Asteroid a){
    for(double i = this.x - 32; i < this.x + 32; i++){
      for(double j = this.y -32; j < this.y + 32; j++){
        if(i == a.x || j == a.y){
          a.hit = true;
          return true;
        }
      }
    }
    return false;
  }
}

class Asteroid{
  double x = 0;
  double y = 0;
  bool hit = false;

  View view;

  ImageElement asteroid = new ImageElement();

  Asteroid(this.x, this.y, this.view){
    this.x = x;
    this.y = y;
    this.view = view;
    this.asteroid.src = "Assets/astroid.png";
    this.asteroid.className = "asteroid";
    view.background.children.add(asteroid);
  }

  void update(){
    if(this.hit){
      this.x = null;
      this.y = null;
    }
  }

  double get curr_x => this.x;

  double get curr_y => this.y;

  bool isHit(){
    return hit;
  }
}*/