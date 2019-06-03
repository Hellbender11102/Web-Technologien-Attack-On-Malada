import 'dart:html';

class Shot{
  bool missed = false;
  int speed;
  double posX, posY;
  ImageElement shot = new ImageElement();
  var screen = querySelector("#screen");

  Shot(this.speed, this.posX, this.posY){
    this.shot.src = "Assets/laserBeam.png";
    this.shot.className = "shot";
    this.shot.style.position = "absolute";
    this.shot.style.bottom = "${posY}px";
    this.shot.style.left = "${posX}px";
    this.screen.children.add(shot);
  }

  void move(){
    if((posY - speed) > 0){
      posY -= speed;
    } else {
      missed = true;
    }
    this.shot.querySelector(".shot");
    this.shot.style.bottom = "${posY}px";
    this.shot.style.left = "${posX}px";
  }

  ImageElement getImage(){
    return this.shot;
  }
}