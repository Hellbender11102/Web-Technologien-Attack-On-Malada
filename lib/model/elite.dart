import 'enemy.dart';
import 'player.dart';
import 'dart:html';
import 'shot.dart';

class Elite extends Enemy {
  ImageElement elite = new ImageElement();
  var screen = querySelector("#screen");
  int maxX, maxY;
  bool dead = false;

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

  @override void cleverMove(ImageElement crosshair) {
    var rectCross = crosshair.getBoundingClientRect();
    if ((curr_pos_Y - 0.4) > 140) {
      curr_pos_Y -= 0.4;
    }
    if(((curr_pos_Y + 22) - rectCross.right) < 200){
      if((curr_pos_X + 15) < maxX){
        curr_pos_X += 15;
      }
    } else if (((curr_pos_X + 20) - rectCross.bottom) < 200){
      if((curr_pos_Y - 15) < 140){
        curr_pos_Y -= 15;
      }
    } else if(curr_pos_Y < 150){
      if((curr_pos_X + 20) > maxX / 2){
        curr_pos_X -= 15;
      }
    }
    
    this.elite.querySelector(".casual");
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
