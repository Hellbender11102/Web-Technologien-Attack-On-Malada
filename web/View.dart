import 'dart:html';


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

  List<Asteroid> enemies = [new Asteroid(250, 250), new Asteroid(500,300), new Asteroid(325,325), new Asteroid(540, 450), new Asteroid(740, 300), new Asteroid(500, 700), new Asteroid(800, 825), new Asteroid(1000, 800), new Asteroid(800, 600)];

  List<Asteroid> get enemyList => enemies;

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

  void update(int xPos, int yPos){
    this.crosshair = querySelector(".cross");
    this.crosshair.style.bottom = "${yPos}px";
    this.crosshair.style.left = "${xPos}px";

    for(int i = 0; i < enemyList.length; i++){
      enemyList[i].moveDown();
    }

    for(int i = xPos - 32; i < xPos + 32; i++){
      for(int j = yPos - 32; j < yPos +32; j++){
        for(int k = 0; k < enemyList.length; k++){
          if(i == enemyList[k].ast_x && j == enemyList[k].ast_y){
            enemyList[k].asteroid.src = "";
          }
        }
      }
    }
  }
}

class Asteroid{
  var enemy = querySelector("#enemy_asteroid");
  var screen = querySelector("#screen");
   int get width => window.innerWidth;
  /**
   * Höhe des Views
   */
  int get height => window.innerHeight;
  
  double ast_x;
  double ast_y;

  double get xPos => ast_x;

  double get yPos => ast_y;

  ImageElement asteroid = new ImageElement();

  Asteroid(int x, int y){
    this.asteroid.src = "Assets/asteroid_fix.png";
    this.asteroid.className = "asteroid";
    this.asteroid.style.position = "absolute";
    this.asteroid.style.bottom = "${y}px";
    this.asteroid.style.left = "${x}px";
    this.screen.children.add(asteroid);

    ast_x = x.toDouble();
    ast_y = y.toDouble();
  }

  moveDown(){
    double newY = ast_y - 1;
    this.asteroid.style.bottom = "${newY}px";
    this.asteroid.style.left = "${ast_x}px";
  }
}