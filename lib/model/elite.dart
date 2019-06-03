import 'enemy.dart';
import 'player.dart';
import 'dart:html';
import 'shot.dart';
import 'dart:math';

class Elite extends Enemy {
  ImageElement elite = new ImageElement();
  var screen = querySelector("#screen");
  int maxX, maxY;
  bool dead = false;
  bool strafeLeft = false;

  //constructor shall also set heavy
  Elite(int life_start, double posX, double posY)
      : super(life_start, posX, posY) {
    this.life = life_start;
    this.curr_pos_X = posX;
    this.curr_pos_Y = posY;
    maxX = screen.clientWidth - 70;
    maxY = screen.clientHeight;

    this.elite.src = "Assets/elite.png";
    this.elite.className = "elite";
    this.elite.style.position = "absolute";
    this.elite.style.bottom = "${curr_pos_Y}px";
    this.elite.style.left = "${curr_pos_X}px";
    this.screen.children.add(elite);
  }

  //Shoot function for controller. Whether it hits or not is up to controller or world
  @override
  Shot shoot() {
    return new Shot(15, curr_pos_X + 20, curr_pos_Y - 44);
  }

  @override void cleverMove(int posX, int posY) {
    if ((curr_pos_Y - 1) > 200) {
      curr_pos_Y -= 1;
    }
    if (!strafeLeft) {
      if ((curr_pos_X + 9) < screen.clientWidth - 70) {
        curr_pos_X += 9;
      } else {
        strafeLeft = true;
      }
    } else {
      if ((curr_pos_X - 9) > 0) {
        curr_pos_X -= 9;
      } else {
        strafeLeft = false;
      }
    }
    if((curr_pos_Y > posY) && (curr_pos_X > posX) && ((curr_pos_X - posX) < 150) && (curr_pos_Y - posY) < 150){
      if((curr_pos_Y + 6) < maxY){
        curr_pos_Y += 6;
        strafeLeft = false;
      }
    } else if ((curr_pos_Y > posY) && (curr_pos_X < posX) && ((posX - curr_pos_X) < 150) && (curr_pos_Y - posY) < 150){
      if((curr_pos_Y + 6) < maxY){
        curr_pos_Y += 6;
        strafeLeft = true;
      }
    } else if ((curr_pos_Y + 22 < posY) && (curr_pos_X < posX) && ((posX - curr_pos_X) < 150) && (posY - curr_pos_Y + 22) < 150){
      if((curr_pos_Y - 6) < maxY){
        curr_pos_Y -= 6;
        strafeLeft = true;
      }
    } else if ((curr_pos_Y + 22 < posY) && (curr_pos_X > posX) && ((curr_pos_X - posX) < 150) && (posY - curr_pos_Y + 22) < 150){
      if((curr_pos_Y - 6) < maxY){
        curr_pos_Y -= 6;
        strafeLeft = false;
      }
    } else if(curr_pos_Y < 150){
      var rand = new Random();
      curr_pos_X = rand.nextDouble() * maxX;
      curr_pos_Y = rand.nextDouble() * maxY;
    }
    
    this.elite.querySelector(".elite");
    this.elite.style.bottom = "${curr_pos_Y}px";
    this.elite.style.left = "${curr_pos_X}px";
  }

  @override
  ImageElement getImage() {
    return this.elite;
  }

  @override bool isInView() {
    if (curr_pos_Y <= screen.clientHeight) {
      return true;
    } else {
      return false;
    }
  }
}
