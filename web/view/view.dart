import 'dart:html';
import '../model/asteroid.dart';
import '../model/enemy.dart';

class View {
  var screen = querySelector("#screen");
  var player = querySelector("#player");
  var cross = querySelector("#cross");
  var start = querySelector("#start");
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

    this.startBtn.src = "Assets/startButton.png";
    this.startBtn.className = "start";
    this.startBtn.style.position = "absolute";
    this.startBtn.style.zIndex = "3";
    this.startBtn.style.bottom = "${50}%";
    this.startBtn.style.left = "${45}%";
    this.screen.children.add(startBtn);

    this.life.src = "Assets/hearts_6.png";
    this.life.className = "life";
    this.life.style.position = "absolute";
    this.life.style.bottom = "${90}%";
    this.life.style.left = "${46}%";
    this.screen.children.add(life);
  }

  Asteroid spawnAsteroid(double offset){
    Asteroid newAst = new Asteroid(1, offset, window.innerHeight.toDouble());
    return newAst;
  }

  void update(int xPos, int yPos, List<Asteroid> enemyList) {
    this.crosshair = querySelector(".cross");
    this.crosshair.style.bottom = "${yPos}px";
    this.crosshair.style.left = "${xPos}px";

    for (int a = 0; a < enemyList.length; a++) {
      enemyList[a].move();
      if(enemyList[a].life<=0){
        enemyList.removeAt(a);
      }
    }

    var rectP = player.getBoundingClientRect();

    for (int k = 0; k < enemyList.length; k++) {
      var rectA = enemyList[k].asteroid.getBoundingClientRect();
      var overlapAP = !(rectA.right < rectP.left ||
          rectA.left > rectP.right ||
          rectA.bottom < rectP.top ||
          rectA.top > rectP.bottom);
      if (overlapAP) {
        counter--;
        switch (counter) {
          case 150:
            {
              this.life.src = "Assets/hearts_5.png";
            }
            break;

          case 120:
            {
              this.life.src = "Assets/hearts_4.png";
            }
            break;

          case 90:
            {
              this.life.src = "Assets/hearts_3.png";
            }
            break;

          case 60:
            {
              this.life.src = "Assets/hearts_2.png";
            }
            break;

          case 30:
            {
              this.life.src = "Assets/hearts_1.png";
            }
            break;

          case 0:
            {
              this.life.src = "Assets/hearts_0.png";
            }
            break;
        }
      }
    }
  }

  void showEndWin(){
    win.src = "Assets/Win.jpg";
    win.className = "win";
    win.style.position = "absolute";
    win.style.zIndex = "5";
    win.style.bottom = "${55}%";
    win.style.left = "${46}%";
    screen.children.add(win);

    restart.src = "Assets/Restart.jpg";
    restart.className = "restart";
    restart.style.position = "absolute";
    restart.style.zIndex = "5";
    restart.style.bottom = "${45}%";
    restart.style.left = "${46}%";
    screen.children.add(restart);
  }

  void showEndLose(){
    lose.src = "Assets/GameOver.jpg";
    lose.className = "lose";
    lose.style.position = "absolute";
    lose.style.zIndex = "5";
    lose.style.bottom = "${55}%";
    lose.style.left = "${46}%";
    screen.children.add(lose);

    restart.src = "Assets/Restart.jpg";
    restart.className = "restart";
    restart.style.position = "absolute";
    restart.style.zIndex = "5";
    restart.style.bottom = "${45}%";
    restart.style.left = "${46}%";
    screen.children.add(restart);
  }
}
