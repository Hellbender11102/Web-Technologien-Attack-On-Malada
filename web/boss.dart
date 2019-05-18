import 'enemy.dart';
import 'player.dart';

class Boss extends Enemy{
  //Shield and regeneration shall be handeled in the world controller
  //Same with shooting/being shot, due to different behaviours form 'normal' enemies
  int shield;

  Boss(int life_start, double posX, double posY, int shield) : super(life_start, posX, posY){
    this.shield = shield;
  }
  
  //Shooting function. Whether it hits or not is up to controller/world
  void shoot(Player player){
    player.life -= this.damage;
  }

  //TBD
  void specialAttack(){

  }

  //regeneration will be handled by controller/world
  void regenerate(int regenRate){
    this.shield += regenRate;
  }
}