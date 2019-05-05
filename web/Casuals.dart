import 'Enemy.dart';
import 'Player.dart';

class Casual extends Enemy{
  //determines, if enemy does alot of damage. Give it like a 10% chance to happen for extra challenge
  bool heavy;

  //constructor shall also set heavy
  Casual(int life_start, double posX, double posY, bool isHeavy) : super(life_start, posX, posY){
    this.heavy = isHeavy;
    this.life = life_start;
    this.curr_pos_X = posX;
    this.curr_pos_Y = posY;
  }

  //Shoot function for controller. Whether it hits or not is up to controller or world
  void shoot(Player player){
    //Check if heavy for damage
    heavy ? player.life -= this.damage*2 : player.life -= this.damage;
  }

  //TBD Something something playerposition
  void dodge(Player player){

  }
}