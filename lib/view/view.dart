import 'dart:html';
import '../model/asteroid.dart';
import '../model/enemy.dart';
import '../model/shot.dart';
import '../model/player.dart';
import '../model/elite.dart';

class View {
  var screen = querySelector("#screen");
  var player = querySelector("#player");
  var cross = querySelector("#cross");
  var start = querySelector("#start");
  bool noHpLeft = false;
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

  ImageElement startBtn = new ImageElement();
  ImageElement win = new ImageElement();
  ImageElement restart = new ImageElement();
  ImageElement lose = new ImageElement();
  ImageElement level = new ImageElement();
  ImageElement next = new ImageElement();

  View() {
    cross_x = center_x;
    cross_y = center_y;

    this.crosshair.src = "Assets/cross.png";
    this.crosshair.className = "cross";
    this.crosshair.style.position = "absolute";
    this.crosshair.style.zIndex = "2";
    this.crosshair.style.bottom = "${cross_y}px";
    this.crosshair.style.left = "${cross_x}px";
    this.screen.children.add(crosshair);

    this.startBtn.src = "Assets/start.png";
    this.startBtn.className = "start";
    this.startBtn.style.position = "absolute";
    this.startBtn.style.zIndex = "3";
    this.startBtn.style.bottom = "${50}%";
    this.startBtn.style.left = "${center_x - 165}px";
    this.screen.children.add(startBtn);

    this.life.src = "Assets/hearts_6.png";
    this.life.className = "life";
    this.life.style.position = "absolute";
    this.life.style.bottom = "${90}%";
    this.life.style.left = "${center_x - 96}px";
    this.screen.children.add(life);
  }

  void collisionCheckShots(List<Shot> shots, Player toCheck){
    var rectP = player.getBoundingClientRect();

    for (int i = 0; i < shots.length; i++) {
      var rectA = shots[i].getImage().getBoundingClientRect();
      var overlapAP = !(rectA.right < rectP.left ||
          rectA.left > rectP.right ||
          rectA.bottom < rectP.top ||
          rectA.top > rectP.bottom);
      if (overlapAP) {
        if(toCheck.life >= 2){
          toCheck.life -= 2;
        } else {
          toCheck.life = 0;
        }
        shots[i].getImage().remove();
        shots.removeAt(i);
      }
    }
  }

  void collisionCheck(List<Enemy> enemyList, Player toCheck){
    var rectP = player.getBoundingClientRect();

    for (int k = 0; k < enemyList.length; k++) {
      var rectA = enemyList[k].getImage().getBoundingClientRect();
      var overlapAP = !(rectA.right < rectP.left ||
          rectA.left > rectP.right ||
          rectA.bottom < rectP.top ||
          rectA.top > rectP.bottom);
      if (overlapAP) {
        counter--;
        if(counter < 180 && counter % 30 == 0){
          toCheck.life--;
        }
      }
    }
    switch (toCheck.life) {
          case 5:
            {
              this.life.src = "Assets/hearts_5.png";
            }
            break;

          case 4:
            {
              this.life.src = "Assets/hearts_4.png";
            }
            break;

          case 3:
            {
              this.life.src = "Assets/hearts_3.png";
            }
            break;

          case 2:
            {
              this.life.src = "Assets/hearts_2.png";
            }
            break;

          case 1:
            {
              this.life.src = "Assets/hearts_1.png";
            }
            break;

          case 0:
            {
              this.life.src = "Assets/hearts_0.png";
              noHpLeft = true;
            }
            break;
        }
  }

  void update(int xPos, int yPos, List<Enemy> enemyList) {
    this.crosshair = querySelector(".cross");
    this.crosshair.style.bottom = "${yPos}px";
    this.crosshair.style.left = "${xPos}px";

    for (int a = 0; a < enemyList.length; a++) {
      if(enemyList[a] is Elite){
        enemyList[a].cleverMove(this.crosshair);
      } else {
        enemyList[a].move();
      }
    }
  }

  void updateShots(List<Shot> shots){
    for(int i = 0; i < shots.length; i++){
      shots[i].move();
      if(shots[i].missed == true){
        shots[i].getImage().remove();
        shots.removeAt(i);
      }
    }
  }

  void showEndWin(){
    win.src = "Assets/Win.png";
    win.className = "win";
    win.style.position = "absolute";
    win.style.zIndex = "5";
    win.style.bottom = "${center_y + 65}px";
    win.style.left = "${center_x - 165}px";
    screen.children.add(win);

    next.src = "Assets/Next.png";
    next.className = "next";
    next.style.position = "absolute";
    next.style.zIndex = "5";
    next.style.bottom = "${center_y - 65}px";
    next.style.left = "${center_x - 165}px";
    screen.children.add(next);
  }

  void showEndLose(){
    lose.src = "Assets/GameOver.png";
    lose.className = "lose";
    lose.style.position = "absolute";
    lose.style.zIndex = "5";
    lose.style.bottom = "${center_y + 65}px";
    lose.style.left = "${center_x - 165}px";
    screen.children.add(lose);

    restart.src = "Assets/restart.png";
    restart.className = "restart";
    restart.style.position = "absolute";
    restart.style.zIndex = "5";
    restart.style.bottom = "${center_y - 65}px";
    restart.style.left = "${center_x - 165}px";
    screen.children.add(restart);
  }

  void clearScreen(){
    for(int i = 1; i < screen.children.length; i++){
      screen.children[i].remove();
    }
  }
}
