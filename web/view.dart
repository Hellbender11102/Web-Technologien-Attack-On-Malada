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

  ImageElement life = new ImageElement();
  int counter = 180;

  List<Asteroid> enemies = [new Asteroid(250, 250), new Asteroid(500,300), new Asteroid(325,325), new Asteroid(540, 450), new Asteroid(740, 300), new Asteroid(500, 700), new Asteroid(800, 825), new Asteroid(1000, 800), new Asteroid(800, 600)];

  List<Asteroid> get enemyList => enemies;

  View(){
    this.crosshair.src = "Assets/cross.png";
    this.crosshair.className = "cross";
    this.crosshair.style.position = "absolute";
    this.crosshair.style.bottom = "${cross_y}px";
    this.crosshair.style.left = "${cross_x}px";
    this.screen.children.add(crosshair);

    this.life.src = "Assets/hearts_6.png";
    this.life.className = "life";
    this.life.style.position = "absolute";
    this.life.style.bottom = "${90}%";
    this.life.style.left = "${46}%";
    this.screen.children.add(life);
    
    cross_x = center_x;
    cross_y = center_y;
  }

  void update(int xPos, int yPos){
    this.crosshair = querySelector(".cross");
    this.crosshair.style.bottom = "${yPos}px";
    this.crosshair.style.left = "${xPos}px";

    for(int a = 0; a < enemyList.length; a++){
      enemyList[a].moveDown();
    }

    var rectP = player.getBoundingClientRect();
    var rectC = this.crosshair.getBoundingClientRect();

    for(int k = 0; k < enemyList.length; k++){
         var rectA = enemyList[k].asteroid.getBoundingClientRect();
         var overlapAC = !(rectA.right < rectC.left || 
               rectA.left > rectC.right || 
               rectA.bottom < rectC.top || 
               rectA.top > rectC.bottom);
         var overlapAP = !(rectA.right < rectP.left || 
               rectA.left > rectP.right || 
               rectA.bottom < rectP.top || 
               rectA.top > rectP.bottom);
         if(overlapAC){
            enemyList[k].dead = true;
            enemyList[k].asteroid.src = "";
            enemyList.removeAt(k);
         } else if(overlapAP) {
            counter--;
            switch(counter) {
              case 150: { this.life.src = "Assets/hearts_5.png"; }
              break;

              case 120: { this.life.src = "Assets/hearts_4.png"; }
              break;

              case 90: { this.life.src = "Assets/hearts_3.png"; }
              break;

              case 60: { this.life.src = "Assets/hearts_2.png"; }
              break;

              case 30: { this.life.src = "Assets/hearts_1.png"; }
              break;

              case 0: { this.life.src = "Assets/hearts_0.png"; }
              break;
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
  bool dead = false;

  double get xPos => ast_x;

  double get yPos => ast_y;

  ImageElement asteroid = new ImageElement();

  Asteroid(int x, int y){
    this.asteroid.src = "Assets/asteroid_fix.png";
    this.asteroid.className = "enemy_asteroid";
    this.asteroid.style.position = "absolute";
    this.asteroid.style.bottom = "${y}px";
    this.asteroid.style.left = "${x}px";
    this.screen.children.add(asteroid);

    ast_x = x.toDouble();
    ast_y = y.toDouble();
  }

  moveDown(){
    if((ast_y - 1) > 0){
      ast_y -= 1;
    } else {
      this.asteroid.src = "";
      dead = true;
    }
    this.asteroid.querySelector(".enemy_asteroid");
    this.asteroid.style.bottom = "${ast_y}px";
  }
}