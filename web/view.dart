import 'dart:html';
import 'asteroid.dart';

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

  View(){
    this.crosshair.src = "Assets/cross.png";
    this.crosshair.className = "cross";
    this.crosshair.style.position = "absolute";
    this.crosshair.style.zIndex = "2";
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

  void update(int xPos, int yPos, List<Asteroid> enemyList){
    this.crosshair = querySelector(".cross");
    this.crosshair.style.bottom = "${yPos}px";
    this.crosshair.style.left = "${xPos}px";

    for(int a = 0; a < enemyList.length; a++){
      enemyList[a].moveDown();
    }

    var rectP = player.getBoundingClientRect();

    for(int k = 0; k < enemyList.length; k++){
         var rectA = enemyList[k].asteroid.getBoundingClientRect();
         var overlapAP = !(rectA.right < rectP.left || 
               rectA.left > rectP.right || 
               rectA.bottom < rectP.top || 
               rectA.top > rectP.bottom);
          if(overlapAP) {
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