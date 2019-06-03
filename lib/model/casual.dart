import 'enemy.dart';
import 'player.dart';
import 'dart:html';
import 'shot.dart';

class Casual extends Enemy {
  //determines, if enemy does alot of damage. Give it like a 10% chance to happen for extra challenge
  bool heavy;
  ImageElement casual = new ImageElement();
  var screen = querySelector("#screen");
  bool strafeLeft = false;
  bool dead = false;

  //constructor shall also set heavy
  Casual(int life_start, double posX, double posY, bool isHeavy)
      : super(life_start, posX, posY) {
    this.heavy = isHeavy;
    this.life = life_start;
    this.curr_pos_X = posX;
    this.curr_pos_Y = posY;

    this.casual.src = "Assets/casual.png";
    this.casual.className = "casual";
    this.casual.style.position = "absolute";
    this.casual.style.bottom = "${curr_pos_Y}px";
    this.casual.style.left = "${curr_pos_X}px";
    this.screen.children.add(casual);
  }

  //Shoot function for controller. Whether it hits or not is up to controller or world
  @override
  Shot shoot() {
    return new Shot(10, curr_pos_X + 30, curr_pos_Y - 48);

  }

  @override
  void move() {
    if ((curr_pos_Y - 1) > 200) {
      curr_pos_Y -= 1;
    }
    if (!strafeLeft) {
      if ((curr_pos_X + 6) < screen.clientWidth - 70) {
        curr_pos_X += 6;
      } else {
        strafeLeft = true;
      }
    } else {
      if ((curr_pos_X - 6) > 0) {
        curr_pos_X -= 6;
      } else {
        strafeLeft = false;
      }
    }
    this.casual.querySelector(".casual");
    this.casual.style.bottom = "${curr_pos_Y}px";
    this.casual.style.left = "${curr_pos_X}px";
  }

  @override
  ImageElement getImage() {
    return this.casual;
  }

  @override bool isInView() {
    if (curr_pos_Y <= screen.clientHeight) {
      return true;
    } else {
      return false;
    }
  }
}
